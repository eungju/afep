require 'json'
require 'net/http'
require 'net/https'

RPXAPIKEY = "40fd6bb81c1904df2bff431dd85b4db4b59f4c42"

class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:rpx]
  
  def welcome
  end
  
  def signout
    session.delete(:user_id)
    redirect_to '/'
  end
  
  def rpx
    u = URI.parse('https://rpxnow.com/api/v2/auth_info')
    req = Net::HTTP::Post.new(u.path)
    req.set_form_data({'token' => params[:token],
                        'apiKey' => RPXAPIKEY,
                        'format' => 'json'})

    http = Net::HTTP.new(u.host,u.port)
    http.use_ssl = true if u.scheme == 'https'
    res = http.request(req)

    json_resp = res.body
    json = JSON.parse(json_resp)

    if json['stat'] == 'ok'
      unique_identifier = json['profile']['identifier']
      nickname = json['profile']['preferredUsername']
      nickname = json['profile']['displayName'] if nickname.nil?
      email = json['profile']['email']
      photo_url = json['profile']['photo']

      # implement your own do_success method which signs the user in
      # to your website
      #do_success(unique_identifier,email,nickname,photo_url)
      session[:user_id] = unique_identifier
      redirect_to :controller => :task
    else
      flash[:notice] = 'Sign-in failed'
      redirect_to '/'
    end
  end
end
