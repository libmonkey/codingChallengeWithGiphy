module HomeHelper

  def giphy_random_api()
    giphys = Array.new
    uri = URI("http://api.giphy.com/v1/gifs/random")
    params = {api_key: Rails.application.credentials.giphy_api_key}
    uri.query = URI.encode_www_form(params)

    response = self.api_request(uri, 20)

    giphys = Array.new

    response.each do |giphy|
      giphys << Giphy.new(giphy["data"])
    end

    return giphys
  end

  def giphy_search(search, offset = 0)
    giphys = Array.new
    uri = URI("http://api.giphy.com/v1/gifs/search")
    params = {api_key: Rails.application.credentials.giphy_api_key,
      q: search ,
      limit: 20,
      offset: offset
    }
    uri.query = URI.encode_www_form(params)

    response = self.api_request(uri)

    giphys = Array.new
    response.first["data"].each do |giphy|
      giphys << Giphy.new(giphy)
    end

    giphySearch = GiphySearch.new(response.first["pagination"])
    giphySearch.giphys = giphys

    return giphySearch
  end

  private

  def api_request(uri, number_of_requests = 1)
    giphys = Array.new

    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new(uri)

      number_of_requests.times do
        response = http.request(request)
        giphys << JSON.parse(response.body)
      end
    end

    return giphys
  end
end
