class RatingsController < ApplicationController

  def create
    @rating = Rating.new(description: params[:rating][:description],
                         user_id: current_user.id,
                         product_id: params[:product_id],
                         rating: params[:rating][:rating])
    if @rating.save
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:notice] = "Unable to save review"
      redirect_to "/products/#{params[:product_id]}"
    end
  end
end