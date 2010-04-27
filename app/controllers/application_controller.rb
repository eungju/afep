# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authorize, :except => [:welcome, :rpx]

  def authorize
    unless session[:user_id]
      redirect_to :controller => :home, :action => :welcome
    end
    @user = session[:user_id]
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
