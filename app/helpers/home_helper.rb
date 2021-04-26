module HomeHelper

  def HomeHelper.giphy_random_api()
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

  def HomeHelper.giphy_search(search)
    giphys = Array.new
    uri = URI("http://api.giphy.com/v1/gifs/search")
    params = {api_key: Rails.application.credentials.giphy_api_key, q: search , limit: 20}
    uri.query = URI.encode_www_form(params)

    response = self.api_request(uri)

    giphys = Array.new

    response.first["data"].each do |giphy|
      giphys << Giphy.new(giphy)
    end

    return giphys
  end

  private

  def self.api_request(uri, number_of_requests = 1)
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
