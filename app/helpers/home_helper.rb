module HomeHelper

  def HomeHelper.giphy_random_api(number)
    giphys = Array.new
    url = URI("http://api.giphy.com/v1/gifs/random")

    Net::HTTP.start(url.host, url.port) do |http|
      request = Net::HTTP::Get.new(url)
      request["api_key"] = Rails.application.credentials.giphy_api_key

      number.times {
        response = http.request(request)

        giphys << JSON.parse(response.body)
      }
    end

    giphys
  end
end
