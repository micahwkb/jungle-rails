class RatingsController < ApplicationController

  def create
    Rating.create(content: params[:rating][:content], product_id: params[:product_id])
    redirect_to "/products/#{params[:product_id]}"
  end
end