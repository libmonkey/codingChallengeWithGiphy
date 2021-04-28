class GiphySearch

  attr_reader :offset, :total_count, :count
  attr_accessor :giphys

  def initialize(attributes = {})
    @offset = attributes["offset"]
    @total_count = attributes["total_count"]
    @count = attributes["count"]
  end
end
