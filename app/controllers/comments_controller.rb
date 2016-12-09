class CommentsController < ApplicationController

  def create
    Comment.create(content: params[:comment][:content], product_id: params[:product_id])
    redirect_to "/products/#{params[:product_id]}"
  end

end
