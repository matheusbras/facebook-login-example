# encoding: UTF-8
class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to secret_page_path, :notice => "Opa! Você está online!"
  end

  def failure
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Volte em breve!"
  end
end
