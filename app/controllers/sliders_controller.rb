class SlidersController < ApplicationController
  load_and_authorize_resource

  layout 'admin'

  def index
    @sliders = Slider.newest

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sliders }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slider }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slider }
    end
  end

  def create
    respond_to do |format|
      if @slider.save
        format.html { redirect_to @slider, notice: 'Slider was successfully created.' }
        format.json { render json: @slider, status: :created, location: @slider }
      else
        format.html { render action: "new" }
        format.json { render json: @slider.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @slider.update_attributes(params[:slider])
        format.html { redirect_to @slider, notice: 'Slider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slider.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @slider.destroy

    respond_to do |format|
      format.html { redirect_to sliders_url }
      format.json { head :no_content }
    end
  end
end
