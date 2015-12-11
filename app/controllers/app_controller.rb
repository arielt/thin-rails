class AppController < ApplicationController

  def index
    Rails.logger.debug "quering redis cache"
    $redis.get "local"
    render :json => {status: "Ok"}
  end

end
