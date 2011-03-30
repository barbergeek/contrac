class InputRecordsController < ApplicationController

  before_filter :authenticate_user!

  
  # GET /input_records/import
  # just render the template
  def import
  end
  
  # POST /input_records/upload
  def upload
    if params[:datafile]
      if params[:import_job]
        job = Job.create!(:jobtype => :input, :data => params[:datafile].read)
        Delayed::Job.enqueue ImportJob.new(job.id)
        flash[:success] = "Import and Merge job queued"
        redirect_to input_records_path
      else
        job = ImportJob.new
        job.import_and_merge(params[:datafile].read)
        flash[:success] = "job processed"
        redirect_to input_records_path
      end
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
    job = ImportJob.new
    job.merge_input_data
    flash[:notice] = "Data merged"
    redirect_to input_records_path
  end

end
