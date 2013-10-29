class PagesController < ApplicationController
  load_and_authorize_resource except: [:home, :blog, :blog_post, :events, :event,
                                       :business, :front, :vouchers, :voucher, :admin, :businesses,
                                       :shoppings, :shopping, :businesses_category,
                                       :static_page, :visiting, :guides]

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
    render layout: 'common'
  end

  def event
    @event = Event.find(params[:id])
  end

  # Shopping & Eating and Drinking menu
  def businesses_category
    options = params.except(:controller, :action)
    tag = options.delete(:tag) if options.has_key? :tag

    @businesses = Business.where(category: params[:cat])
    @businesses = @businesses.where(:services => /#{tag}/) if tag.present?

    @starts_with = params[:starts_with] || @businesses.map(&:name).sort.first.downcase[0]
    @paginated_businesses = @businesses.select { |b| b.name.downcase.starts_with?(@starts_with) }

    @template = BusinessCategoryTemplate.where(category: params[:cat]).first

    @random_services = Business.random_services(20, params[:cat])

    render layout: 'category'
  end

  def business
    @business = Business.find params[:id]
  end
  # End Shopping... menu.

  def vouchers
    @deals = Deal.approved.page params[:page]
    render layout: 'common'
  end

  def voucher
    @deal = Deal.find params[:id]
    redirect_to public_vouchers_path if @deal.unapproved?
  end

  def visiting
  end

  def guides
    businesses = Business.all
    @hash = Gmaps4rails.build_markers(businesses) do |b, m|
      m.lat b.lat
      m.lng b.lon
    end
  end

  def static_page
    @page = PageTemplate.find(params[:id])
  end
end
