class Api::V1::DealsController < ApplicationController
  respond_to :json

  def index
    #@deals = Deal.approved.available.newest
    @deals = Deal.newest
    respond_with @deals
  end

  def show
    @deal = Deal.find(params[:id])
    respond_with @deal
  end
end
