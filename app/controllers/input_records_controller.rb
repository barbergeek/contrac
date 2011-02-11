class InputRecordsController < ApplicationController

  before_filter :authenticate_user!

  # GET /input_records/import
  # just render the template
  def import
  end
  
  # POST /input_records/upload
  def upload
    if params[:datafile]
      records = import_input_data(params[:datafile].read)
      flash[:success] = pluralize(records,"records") + " processed"
      redirect_to input_records_path
    else
      flash[:error] = "Data file not uploaded"
      redirect_to import_input_records_path
    end
  end
  
  # GET /input_records
  # GET /input_records.xml
  def index
    @input_records = InputRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @input_records }
    end
  end

  # GET /input_records/1
  # GET /input_records/1.xml
  def show
    @input_record = InputRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @input_record }
    end
  end

  # GET /input_records/1/edit
  def edit
    @input_record = InputRecord.find(params[:id])
  end

  # PUT /input_records/1
  # PUT /input_records/1.xml
  def update
    @input_record = InputRecord.find(params[:id])

    respond_to do |format|
      if @input_record.update_attributes(params[:input_record])
        format.html { redirect_to(@input_record, :notice => 'Input record was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @input_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /input_records/1
  # DELETE /input_records/1.xml
  def destroy
    @input_record = InputRecord.find(params[:id])
    @input_record.destroy

    respond_to do |format|
      format.html { redirect_to(input_records_url) }
      format.xml  { head :ok }
    end
  end
  
  def merge
    merge_input_data
    flash[:notice] = "Data merged"
    redirect_to input_records_path
  end

  private
  
    # parse the input export file and insert the data into the InputRecords table
    def import_input_data(data)
      # grab the table out of the data file
      table = /<table[\w\s="'%]*?>(.*)<\/table>/ims.match(data.squish)
      # split into array rows based on <tr></tr> and do some cleanup
      tabledata = table[1].gsub(/\&nbsp;/," ").gsub(/ </,"<").gsub(/> /,">").gsub(/<b>|<\/b>/,"").scan(/<tr>.*?<\/tr>/ims)
      # split by columns and remove extraneous tags
      tabledata.map!{ |row| row.gsub(/<tr><td>/,"").gsub(/<\/td><\/tr>/,"").split("</td><td>")}
    
      data_columns = {
        "Acronym" => :acronym,
        "Title" => :title,
        "Organization" => :organization,
        "RFP #" => :rfp_number,
        "Program Value" => :program_value,
        "RFP Date" => :rfp_date,
        "Status" => :status,
        "User List" => :user_list,
        "Project Award Date" => :project_award_date,
        "Opportunity Id" => :opportunity_id,
        "Contract Type" => :contract_type,
        "Contract Type (Combined List)" => :contract_type_combined,
        "Primary Service" => :primary_service,
        "Contract Duration" => :contract_duration,
        "Last Updated" => :last_updated,
        "Competition Type" => :competition_type,
        "NAICS" => :naics,
        "Primary State of Perf." => :primary_state_of_performance,
        "Summary" => :summary,
        "Comments" => :comments,
        "DOD/Civil" => :dod_civil,
        "Incumbent" => :incumbent,
        "Contractor (Combined List)" => :contractor_combined,
        "Incumbent Value" => :incumbent_value,
        "Incumbent Contract #" => :incumbent_contract_number,
        "Incumbent Award Date" => :incumbent_award_date,
        "Incumbent Expire Date" => :incumbent_expire_date,
        "Priority" => :priority,
        "Vertical" => :vertical,
        "Vertical (Combined List)" => :vertical_combined,
        "Segment" => :segment,
        "Segment (Combined List)" => :segment_combined,
        "Key Contacts" => :key_contacts
      }
      
      # figure out which input columns map to which data columns                                        
      keys = []
      tabledata[0].each_index do |column|
        keys[column] = data_columns[tabledata[0][column]]
      end
      
      # clear all the old data
      InputRecord.delete_all
      
      record_count = 0
      
      # load the data
      tabledata.each_index do |row|   # for each row
        unless row == 0 then            # skip the header row
          record = InputRecord.new      # get a new record
          keys.each_index do |column|    # for each column in the input file, update the attribute
            if keys[column] == :title   #need special processing for title to split URL from actual title
              data = /<a href="(.*?)">(.*?)<\/a>/i.match(tabledata[row][column])
              record.update_attribute(:input_url, data[1]) unless data[1].nil?
              record.update_attribute(:title, data[2]) unless data[2].nil?
            else
              record.update_attribute(keys[column], tabledata[row][column]) unless keys[column].nil? 
            end
          end
          record.save!
          record_count += 1
        end
      end
              
      return record_count
    end
  
    def merge_input_data
      
      input_records = InputRecord.all
      input_records.each do |source|
        current_record = Opportunity.find_by_input_number(source.opportunity_id) || Opportunity.new

        # set INPUT Opportunity ID
        current_record.update_attribute(:input_number, source.opportunity_id) if current_record.input_number.blank?
        
        # merge missing data
        current_record.update_attribute(:acronym, source.acronym) if current_record.acronym.blank? && !source.acronym.blank?
        current_record.update_attribute(:program, source.title) if current_record.program.blank? && !source.title.blank?
        
        if current_record.department.blank? || current_record.agency.blank?
          dept,agency = source.organization.split("/")
          current_record.update_attribute(:department, dept) if current_record.department.blank? && !dept.blank?
          current_record.update_attribute(:agency, agency) if current_record.agency.blank? && !agency.blank?
        end
        
        current_record.update_attribute(:description, source.summary) if current_record.description.blank? && !source.summary.blank?
        current_record.update_attribute(:location, source.primary_state_of_performance) if current_record.location.blank? && !source.primary_state_of_performance.blank?
        current_record.total_value = source.program_value if current_record.total_value.blank? && !source.program_value.blank?
        current_record.contract_length = source.contract_duration if current_record.contract_length.blank? && !source.contract_duration.blank?
        current_record.solicitation_type = source.competition_type if current_record.solicitation_type.blank? && !source.competition_type.blank?
        current_record.contract_type = source.contract_type if current_record.contract_type.blank? && !source.contract_type.blank?
        current_record.rfp_release_date = source.rfp_date if current_record.rfp_release_date.blank? && !source.rfp_date.blank?
        #  rfp_due_date          :date
        current_record.award_date = source.project_award_date if current_record.award_date.blank? && !source.project_award_date.blank?
        
        current_record.save!
      end
    end
    
end
