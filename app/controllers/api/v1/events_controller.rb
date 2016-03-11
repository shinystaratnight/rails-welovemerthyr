class Api::V1::EventsController < ApplicationController
  respond_to :json

  def index
    @events = Event.where(:next_occurrence.gte => Time.now, 
                          :ends.gte => Time.now).asc(:next_occurrence)
    respond_with @events
  end

  def show
    @event = Event.find(params[:id])
    respond_with @event
  end
end
