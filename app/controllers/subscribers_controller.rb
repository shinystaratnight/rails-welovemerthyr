class SubscribersController < ApplicationController
  load_and_authorize_resource except: :callback_facebook

  layout 'admin'

  def index
    @subscribers = Subscriber.newest

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

  # Subscribe from social networks
  #

  # Facebook
  def callback_facebook
    token = env["omniauth.auth"][:credentials][:token]
    name = env["omniauth.auth"][:info][:name]
    email = env["omniauth.auth"][:info][:email]

    # Create new Subscriber record.
    deal = Deal.find(request.env['HTTP_REFERER'].split('?').first.split('/').last)
    @subscriber = Subscriber.new(name: name, email: :email, deal_id: deal.id)
    @subscriber.save

    # Post deal's info to user timeline.
    user = FbGraph::User.me(token)

    if Rails.env.development?
      image_url = deal.image.present?? "http://welovemerthyr.dev#{deal.image_url(:thumb)}" : ''
    elsif Rails.env.production?
      image_url = deal.image.present?? deal.image_url(:thumb) : ''
    end

    user.feed!(
      message: "Voucher from WeLoveMerthyr",
      picture: image_url,
      link: public_voucher_url(deal),
      name: deal.title)
#      description: deal.description.gsub('<p>', '').gsub('</p>', '')
#    )

    redirect_to request.env['HTTP_REFERER'].split('?').first << "?step=2"
  end
end
