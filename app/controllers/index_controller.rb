class IndexController < ApplicationController
  
  #before_action :authenticate_user!
  
  def show
    render html: '', layout: true
  end
  
end
