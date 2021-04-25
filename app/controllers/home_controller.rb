class HomeController < ApplicationController
  def index
      @giphys = HomeHelper::giphy_random_api
  end

  def search
    @giphys = HomeHelper::giphy_search(params[:search_tag])
  end
end
