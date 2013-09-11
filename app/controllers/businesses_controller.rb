class BusinessesController < ApplicationController
  load_and_authorize_resource

  before_filter :fix_check_box, only: [:create, :update]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @businesses }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business }
    end
  end

  def create
    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render json: @business, status: :created, location: @business }
      else
        format.html { render action: "new" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.json { head :no_content }
    end
  end

private

  def fix_check_box
    params[:business].merge!(facebook: 0) unless params[:business].has_key?(:facebook)
  end
end
