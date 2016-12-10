class RatingsController < ApplicationController

  def create
    @rating = Rating.new(description: params[:rating][:description].strip,
                         user_id: current_user.id,
                         product_id: params[:product_id],
                         rating: params[:rating][:rating])
    if @rating.save
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:notice] = "Unable to save your review - was the description empty?"
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def destroy
    # byebug
    @rating = Rating.find params[:id]
    @rating.destroy
    redirect_to product_path(params[:product_id]), notice: 'Rating deleted!'
  end
end