class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  before_action :authenticate
  
  private
  def authenticate
    if !session[:user]
    	redirect_to "/signin"
    end
  end
end
