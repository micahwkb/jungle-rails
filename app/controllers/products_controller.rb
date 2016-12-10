class ProductsController < ApplicationController

  def reviewed_by_current_user
    Rating.where(user_id: current_user.id, product_id: params[:id]).count > 0
  end

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @rating = Rating.new
    @product = Product.find params[:id]
    @average_rating = @product.average_rating.to_i

    if current_user
      @reviewed_by_user = reviewed_by_current_user
    end
  end
end
