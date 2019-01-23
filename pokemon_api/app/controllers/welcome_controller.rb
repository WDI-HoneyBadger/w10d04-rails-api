class WelcomeController < ApplicationController
  def index
    render plain: "Welcome to my site!"
  end

  def show 
    puts params.inspect
    render plain: "Welcome to my site, #{params[:name]}"
  end
end
