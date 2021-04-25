module HomeHelper

  def HomeHelper.giphy_random_api()
    giphys = Array.new
    url = URI("http://api.giphy.com/v1/gifs/random")
    request = Net::HTTP::Get.new(url)

    self.api_request(url, request, 20)
  end

  def HomeHelper.giphy_search(search)
    giphys = Array.new
    url = URI("http://api.giphy.com/v1/gifs/search")
    request = Net::HTTP::Get.new(url)
    request['q'] = "hallo"
    request['limit'] = 20
    debugger
    self.api_request(url, request)
  end

  private

  def self.api_request(url, request, number_of_requests = 1)
    giphys = Array.new

    Net::HTTP.start(url.host, url.port) do |http|
      request["api_key"] = Rails.application.credentials.giphy_api_key

      number_of_requests.times do
        response = http.request(request)

        giphys << JSON.parse(response.body)
      end
    end

    return giphys
  end
end
