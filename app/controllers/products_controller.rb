class ProductsController < ApplicationController

  def reviewed_by_current_user
    Rating.where(user_id: current_user.id, product_id: params[:id]).count > 0
  end

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = validate_product_id(params[:id])
    @rating  = Rating.new

    if current_user
      @reviewed_by_user = reviewed_by_current_user
    end
  end

  def validate_product_id(id)
    if Product.where(id: id).count == 0
      redirect_to root_path
    else
      @product = Product.find(id)
      @average_rating = @product.average_rating.to_i
      @product
    end
  end
end
