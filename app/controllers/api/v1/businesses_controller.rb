class Api::V1::BusinessesController < ApplicationController
  respond_to :json
  PER_PAGE = 20

  def index
    category = params[:category]
    tag = params[:tag]

    @businesses = Business.order_by("name asc")
    @businesses = @businesses.where(category: category) if category.present?
    @businesses = @businesses.where(:services => /#{tag}/) if tag.present?
    @businesses = @businesses.page(params[:page]).per(PER_PAGE)
    respond_with @businesses
  end

  def show
    @business = Business.find(params[:id])
    respond_with @business
  end
end
