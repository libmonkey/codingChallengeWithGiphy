require 'will_paginate/collection'

class HomeController < ApplicationController
  def index
      @giphys = helpers.giphy_random_api
  end

  def search
      page = params[:page].nil? ? 1 : params[:page]
      @giphys = WillPaginate::Collection.create(page, 20) do |pager|
        giphySearch = helpers.giphy_search(params[:search_tag], pager.offset)
        pager.total_entries = giphySearch.total_count

        pager.replace(giphySearch.giphys)
      end
  end

end
