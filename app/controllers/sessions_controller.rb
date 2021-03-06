# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      remember(user)
      flash[:info] = 'User Logged in'
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:info] = 'User logged out.'
    else
      flash[:info] = "User wasn't even logged in."
    end
    redirect_to root_url
  end
end
