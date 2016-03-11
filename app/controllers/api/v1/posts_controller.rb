class Api::V1::PostsController < ApplicationController
  respond_to :json

  def index
    @posts = Post.published.where(:published_at.gte => 6.months.ago).order_by(published_at: :desc)
    respond_with @posts
  end

  def show
    @post = Post.published.find(params[:id])
    respond_with @post
  end
end
