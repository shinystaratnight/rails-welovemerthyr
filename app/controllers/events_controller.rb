class EventsController < ApplicationController
  load_and_authorize_resource

  layout 'admin'

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def create
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
