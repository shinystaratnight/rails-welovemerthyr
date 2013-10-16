class DealsController < ApplicationController
  load_and_authorize_resource

  layout 'deal', only: :index

  def index
    @deals = @deals.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deals }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deal }
    end
  end

  def new
    @business_id = Business.find(params[:business_id]).id if params[:business_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal }
    end
  end

  def edit
    @business_id = @deal.business.id
  end

  def create
    @business_id = Business.find(params[:deal][:business_id]).id if params[:deal][:business_id]

    respond_to do |format|
      if @deal.save
        Notifier.new_deal_created(@deal).deliver

        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render json: @deal, status: :created, location: @deal }
      else
        format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @business_id = Business.find(params[:deal][:business_id]).id if params[:deal][:business_id]

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :no_content }
    end
  end
end
