class ProposalsController < ApplicationController
  # GET /proposals
  # GET /proposals.xml
  def index
    @proposal = Proposal.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @proposals }
    end
  end

  # GET /proposals/1
  # GET /proposals/1.xml
  def show
    # show scaffold
    @proposal = Proposal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proposal }
    end
=begin
  render :json => Proposal.find(params[:id])
=end
  end

  # GET /proposals/new
  # GET /proposals/new.xml
  def new
    @proposal = Proposal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proposal }
    end
  end

  # GET /proposals/1/edit
  def edit
    @proposal = Proposal.find(params[:id])
  end

  # POST /proposals
  # POST /proposals.xml
  def create
 
=begin
    proposal = Proposal.create! params
    render :json => proposal
=end
    # create scaffold
    @proposal = Proposal.new(params[:proposal])

    respond_to do |format|
      if @proposal.save
        flash[:notice] = 'Proposal was successfully created.'
        format.html { redirect_to(@proposal) }
        format.xml  { render :xml => @proposal, :status => :created, :location => @proposal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proposals/1
  # PUT /proposals/1.xml
  def update
=begin
    proposal = Proposal.find(params[:id])
    proposal.update_attributes! params
    render :json => document
=end
    # update scaffold
    @proposal = Proposal.find(params[:id])

    respond_to do |format|
      if @proposal.update_attributes(params[:proposal])
        flash[:notice] = 'Proposal was successfully updated.'
        format.html { redirect_to(@proposal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.xml
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy

    respond_to do |format|
      format.html { redirect_to(proposals_url) }
      format.xml  { head :ok }
    end
  end
end
