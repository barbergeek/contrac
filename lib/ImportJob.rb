class ImportJob < Struct.new(:jobid)

  def perform
    filedata = Job.find(jobid).data
    job = ImportJob.new
    job.import_and_merge(filedata)
  end
  
  def success(job)
    Job.delete(jobid)
  end
  
  def import_and_merge(data) #for Delayed_Job
    if import_input_data(data) > 0
      merge_input_data
    end
  end

  # parse the input export file and insert the data into the InputRecords table
  def import_input_data(data)
  
    # clear all the old data
    #InputRecord.delete_all

    # grab the table out of the data file
    table = /<table.*?>(.*)<\/table>/im.match(data.squish)
    # split into array rows based on <tr></tr> and do some cleanup
    tabledata = table[1].gsub(/\&nbsp;/," ").gsub(/ </,"<").gsub(/> /,">").gsub(/<b>|<\/b>|<img.*?>|<\/img>|<span.*?>|<\/span>|<td.*?>|<a .*?>|<\/a>/,"").scan(/<tr.*?>.*?<\/tr>/im)
    # split by columns and remove extraneous tags
    tabledata.map!{ |row| row.gsub(/<tr.*?>/,"").gsub(/<\/td><\/tr>/,"").force_encoding("UTF-8").gsub(/\u{a0}/,"").split("</td>")}

    data_columns = {
      "Acronym" => :acronym,
      "Title" => :title,
      "Organization" => :organization,
      "Department" => :department,
      "Agency" => :agency,
      "RFP #" => :rfp_number,
      "Solicitation #" => :rfp_number,
      "Program Value" => :program_value,
      "Value($k)" => :program_value,
      "RFP Date" => :rfp_date,
      "Solicitation Date" => :rfp_date,
      "Status" => :status,
      "User List" => :user_list,
      "Project Award Date" => :project_award_date,
      "Projected Award Date" => :project_award_date,
      "Opportunity Id" => :input_opportunity_number,
      "Opp Id" => :input_opportunity_number,
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
      "Latest News" => :comments,
      "DOD/Civil" => :dod_civil,
      "Incumbent" => :incumbent,
      "Contractor" => :incumbent,
      "Contractor (Combined List)" => :contractor_combined,
      "Incumbent Value" => :incumbent_value,
      "Contract Value($k)" => :incumbent_value,
      "Incumbent Contract #" => :incumbent_contract_number,
      "Contract Number" => :incumbent_contract_number,
      "Incumbent Award Date" => :incumbent_award_date,
      "Contract Award Date" => :incumbent_award_date,
      "Incumbent Expire Date" => :incumbent_expire_date,
      "Contract Expire Date" => :incumbent_expire_date,
      "Priority" => :priority,
      "Vertical" => :vertical,
      "Vertical (Combined List)" => :vertical_combined,
      "Segment" => :segment,
      "Segment (Combined List)" => :segment_combined,
      "Key Contacts" => :key_contacts
    }
  
    # figure out which input columns map to which data columns                                        
    keys = []
    cols = {}
    tabledata[0].each_index do |column|
      keys[column] = data_columns[tabledata[0][column].strip]
      cols[data_columns[tabledata[0][column]]] = column
#      puts "found #{keys[column]} in #{cols[data_columns[tabledata[0][column]]]}"
    end
  
    record_count = 0
  
    # load the data
    for row in 1..(tabledata.length-1)   # for each row (except the header row)
#        puts "loading row #{row}"
        opportunity_number_column = cols[:input_opportunity_number]
        opportunity_number = tabledata[row][opportunity_number_column]
        record = InputRecord.find_or_create_by_input_opportunity_number(opportunity_number) # get the record or make a new one
        keys.each_index do |column|    # for each column in the input file, update the attribute
          case keys[column] 
            when :title   #need special processing for title to split URL from actual title
              if tabledata[row][column] =~ /<a/
                data = /<a href="(.*?)">(.*?)<\/a>/i.match(tabledata[row][column])
                record.input_url = data[1] unless data[1].nil?
                record.title = data[2] unless data[2].nil?
              else
                record.title = tabledata[row][column]
              end
            when :department
              @dept = tabledata[row][column]
            when :agency
              if tabledata[row][column].nil?
                record.send("organization=", "#{@dept}")
              else
                record.send("organization=", "#{@dept}/#{tabledata[row][column]}")
              end
            when :rfp_date, :project_award_date, :last_updated, :incumbent_award_date, :incumbent_expire_date
              record.send("#{keys[column]}=",INPUT.fix_input_date(tabledata[row][column]))
            else
              record.send("#{keys[column]}=", tabledata[row][column]) unless keys[column].nil? 
          end
        end
        record.save!
        record_count += 1
    end
          
    return record_count
  end

  def merge_input_data
    InputRecord.all.each do |source|
      source.merge_to_opportunity
    end
  end

#    def fix_date(datevalue)
#      if datevalue =~ /\//
#         m,d,y = datevalue.split("/")
#         "#{y}-#{m}-#{d}"
#       else
#         datevalue
#       end
#    end
    
end
