class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id 
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    @current_user ||= User.find_by(remember_digest: cookies[:remember_token])
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    puts "THIS IS THE USER #{current_user}"
    !current_user.nil?
  end

end
