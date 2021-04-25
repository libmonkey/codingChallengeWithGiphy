class HomeController < ApplicationController
  def index
    if params[:search_tag].nil?
      @giphys = HomeHelper::giphy_random_api
    else
      @giphys = HomeHelper::giphy_search(params[:search_tag])
    end
  end
end
