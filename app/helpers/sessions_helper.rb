# frozen_string_literal: true

module SessionsHelper
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

  def current_user=(user)
    @current_user = user
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end
end
