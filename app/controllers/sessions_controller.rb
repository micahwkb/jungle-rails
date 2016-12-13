class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    else
      redirect_to login_path, notice: 'Invalid login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
