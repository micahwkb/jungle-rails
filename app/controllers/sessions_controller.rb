class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # if user exists AND entered password is correct
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # redirect based on admin status
      if user.admin?
        redirect_to '/admin'
      else
        redirect_to '/'
      end

    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
