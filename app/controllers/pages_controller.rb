class PagesController < ApplicationController
  load_and_authorize_resource except: [:home, :blog, :blog_post, :events, :event,
                                       :business, :front, :vouchers, :admin]

  layout 'common', only: [:vouchers, :events]

  def index
    respond_to do |format|
      format.html { render layout: 'admin' } # index.html.erb
      format.json { render json: @pages }
    end
  end

  def show
    respond_to do |format|
      format.html { render layout: 'admin' }# show.html.erb
      format.json { render json: @page }
    end
  end

  def new
    respond_to do |format|
      format.html { render layout: 'admin' }# new.html.erb
      format.json { render json: @page }
    end
  end

  def create
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Admin dashboard
  def admin
    return redirect_to new_user_session_path unless current_user && current_user.is_admin
    render layout: 'admin'
  end

  #
  # Public pages
  #

  def blog
    @posts = Post.where(status: 'published').page params[:page]
  end

  def blog_post
    @post = Post.find(params[:id])
  end

  def events
    @events = Event.page params[:page]
  end

  def event
    @event = Event.find(params[:id])
  end

  def business
    @business = Business.find(params[:id])
  end

  def vouchers
    @deals = Deal.page params[:page]
  end
end
