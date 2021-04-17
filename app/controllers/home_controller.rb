class HomeController < ApplicationController
  def index
    @giphys = HomeHelper::giphy_random_api(2)
  end
end
