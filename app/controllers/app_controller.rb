class AppController < ApplicationController

  def index
    render :json => {status: "Ok"}
  end

end
