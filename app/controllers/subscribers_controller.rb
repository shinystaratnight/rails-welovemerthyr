class SubscribersController < ApplicationController
  load_and_authorize_resource, except: :subscribe_from_facebook

  layout 'admin'

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscribers }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscriber }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscriber }
    end
  end

  def create
    Rails.logger.info @subscriber.inspect
    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully created.' }
        format.json { render json: @subscriber, status: :created, location: @subscriber }
      else
        format.html { render action: "new" }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscriber.update_attributes(params[:subscriber])
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to subscribers_url }
      format.json { head :no_content }
    end
  end

  def subscribe
    @subscriber = Subscriber.new(params[:subscriber])
    @subscriber.save
  end

  # Subscrib from social network
  #

  # Facebook
  def subscribe_from_facebook
    Rails.logger.info '-' * 100
    Rails.logger.info env["omniauth.auth"].inspect
    Rails.logger.info '-' * 100
  end
end
