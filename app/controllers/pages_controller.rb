class PagesController < ApplicationController
  PER_PAGE = 20

  load_and_authorize_resource except: [:home, :blog, :blog_post, :events, :event,
                                       :business, :front, :vouchers, :voucher, :admin, :businesses,
                                       :shoppings, :shopping, :businesses_category,
                                       :static_page, :visiting, :guides, :public_show, :businesses_results]

  include BusinessesHelper
  include EventsHelper

  def index
    @pages = Page.newest.page(params[:page]).per(PER_PAGE)

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
        format.html { render action: "new", layout: 'admin' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render layout: 'admin'
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", layout: 'admin' }
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
    @posts = Post.published.page params[:page]
    @page_title = 'News'
  end

  def blog_post
    @post = Post.find(params[:id])
    @page_title = @post.title
    return redirect_to blog_path unless @post.published?
  end

  def events
    @events = EnumerableEvents.new(Event.where(:next_occurrence.gte => Time.now, :ends.gte => Time.now).asc(:next_occurrence).group_by(&:starts))
    # events = Event.all
    # @events_by_date = EnumerableEvents.new(Event.all.group_by(&:starts))
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @page_title = 'Events'
    render layout: 'common'
  end

  def event
    @event = Event.find(params[:id])
    @page_title = @event.name

    @hash = [@event].inject([]) do |a, e|
      a << { "lat" => e.lat, "lng" => e.lon, "infowindow" => event_infowindow(e) }
    end
  end

  def businesses_results
    @businesses = Business.search(params[:query]).page(params[:page]).per(10)

    # if @businesses.any?
    #   @starts_with = params[:starts_with] || @businesses.map(&:name).sort.first.downcase[0]
    #   @paginated_businesses = @businesses.select { |b| b.name.downcase.starts_with?(@starts_with) }
    # else
    #   @paginated_businesses = []
    # end

    @random_services = Business.random_services(20)

    @page_title = 'Search results'

    render layout: 'category'
  end

  # Shopping & Eating and Drinking menu
  def businesses_category
    options = params.except(:controller, :action)
    tag = options.delete(:tag) if options.has_key? :tag

    @businesses = Business.where(category: params[:cat]).order_by(:name.asc).page(params[:page]).per(10)
    @businesses = @businesses.where(:services => /#{tag}/) if tag.present?

    # if @businesses.any?
    #   @starts_with = params[:starts_with] || @businesses.map(&:name).sort.first.downcase[0]
    #   @paginated_businesses = @businesses.order_by("name ASC").select { |b| b.name.downcase.starts_with?(@starts_with) }
    # else
    #   @paginated_businesses = []
    # end

    @template = BusinessCategoryTemplate.where(category: params[:cat]).first

    @random_services = Business.random_services(20, params[:cat])

    @page_title = params[:cat]

    render layout: 'category'
  end

  def business
    @business = Business.find params[:id]

    @hash = [@business].inject([]) do |a, b|
      a << { "lat" => b.lat, "lng" => b.lon, "infowindow" => infowindow_single(b) }
    end

    @page_title = @business.name
  end
  # End Shopping... menu.

  def vouchers
    @deals = Deal.approved.available.page params[:page]
    @page_title = 'Vouchers'
    render layout: 'common'
  end

  def voucher
    @deal = Deal.find params[:id]
    @page_title = @deal.title

    respond_to do |format|
      format.html do
        redirect_to public_vouchers_path if @deal.unapproved?
      end
      format.pdf do
        pdf = DealPdf.new(@deal, view_context)
        send_data pdf.render, filename: "#{@deal.title}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def visiting
    @page_title = 'Visiting'
  end

  def guides
    businesses = Business.all.reject { |b| b.lat.blank? || b.lon.blank? }

    @hash = businesses.inject([]) do |a, b|
      a << { "lat" => b.lat, "lng" => b.lon, "infowindow" => infowindow_multiple(b) }
    end

    @page_title = 'Maps & Guides'
  end

  def update_guides_map
    businesses = Business.all.select { |b| params[:selected_cats].include?(b.category) && (b.lat.present? || b.lon.present?) }

    @hash = businesses.inject([]) do |a, b|
      a << { "lat" => b.lat, "lng" => b.lon, "infowindow" => infowindow_multiple(b) }
    end
  end

  def public_show
    @page = Page.find params[:id]
    @page_title = @page.title
    render layout: set_layout
  end

  def static_page
    @page = PageTemplate.find(params[:id])
  end

private

  def set_layout
    @page.page_template.try(:layout_name) || 'application'
  end
end
