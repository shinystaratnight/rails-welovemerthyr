class EventsController < ApplicationController
  PER_PAGE = 20

  load_and_authorize_resource

  layout 'new_admin'

  def index
    @events = Event.newest.page(params[:page]).per(PER_PAGE)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    respond_to do |format|
      # format.html # show.html.erb
      format.html { render layout: 'new_admin' }
      format.json { render json: @event }
    end
  end

  def new
    respond_to do |format|
      # format.html # new.html.erb
      format.html { render layout: 'new_admin' }
      format.json { render json: @event }
    end
  end

  def create
    respond_to do |format|
      if @event.save
        send_to_pushwoosh(@event)
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
        send_to_pushwoosh(@event)
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

  private

  def send_to_pushwoosh(event)
    if !event.notified?
      options = {
        notifications: [
          {
            content: event.description,
          }
        ]
      };

      Pushwoosh.notify_all(event.name, options)
      event.update_attribute(:notified_at, Time.now)
    end
  end
end
