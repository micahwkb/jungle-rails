class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @rating = Rating.new
    @product = Product.find params[:id]
    @comment = Comment.new
  end
end
