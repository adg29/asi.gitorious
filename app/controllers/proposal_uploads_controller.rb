class ProposalUploadsController < ApplicationController
  # GET /proposal_uploads
  # GET /proposal_uploads.xml
  def index
    @proposal_uploads = ProposalUpload.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proposal_uploads }
    end
  end

  # GET /proposal_uploads/1
  # GET /proposal_uploads/1.xml
  def show
    @proposal_upload = ProposalUpload.find(params[:id])

=begin
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proposal_upload }
    end
=end
  end

  # GET /proposal_uploads/new
  # GET /proposal_uploads/new.xml
  def new
    @proposal_upload = ProposalUpload.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proposal_upload }
    end
  end

  # GET /proposal_uploads/1/edit
  def edit
    @proposal_upload = ProposalUpload.find(params[:id])
  end

  def coerce(params) 
    if params[:proposal_upload].nil?
      h = Hash.new 
      h[:proposal_upload] = Hash.new 
      h[:proposal_upload][:upload] = params[:Filedata] 
      h[:proposal_upload][:upload].content_type = MIME::Types.type_for(h[:proposal_upload][:upload].original_filename).to_s
      h 
    else
      params
    end
  end

  # POST /proposal_uploads
  # POST /proposal_uploads.xml
  def create
    newparams = coerce(params)
    @proposal_upload = ProposalUpload.new(newparams[:proposal_upload])

    respond_to do |format|
      if @proposal_upload.save
        flash[:notice] = 'Proposal Upload was successfully created.'
        format.html { redirect_to(@proposal_upload) }
        format.xml  { render :xml => @proposal_upload, :status => :created, :location => @proposal_upload }
        format.json { render :json => { :result => 'success', :file => proposal_upload_path(@proposal_upload) } }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proposal_upload.errors, :status => :unprocessable_entity }
        format.json { render :json => { :result => 'error', :error => @asset.errors.full_messages.to_sentence } }
        format.js
      end
    end
  end

  # PUT /proposal_uploads/1
  # PUT /proposal_uploads/1.xml
  def update
    @proposal_upload = ProposalUpload.find(params[:id])

    respond_to do |format|
      if @proposal_upload.update_attributes(params[:proposal_upload])
        flash[:notice] = 'ProposalUpload was successfully updated.'
        format.html { redirect_to(@proposal_upload) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proposal_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proposal_uploads/1
  # DELETE /proposal_uploads/1.xml
  def destroy
    @proposal_upload = ProposalUpload.find(params[:id])
    @proposal_upload.destroy

    respond_to do |format|
      format.html { redirect_to(proposal_uploads_url) }
      format.xml  { head :ok }
    end
  end
end
