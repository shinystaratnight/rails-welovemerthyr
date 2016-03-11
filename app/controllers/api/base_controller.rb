class Api::BaseController < ApplicationController
  respond_to :json
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :record_not_found

private

  def record_not_found(error)
    render :json => {:error => 'Resource not found'}, :status => :not_found
  end 
end
