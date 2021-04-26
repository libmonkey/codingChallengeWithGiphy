class Giphy

  attr_reader :hash

  def initialize(attributes = {})
    @hash = attributes
  end

  def id
    @hash.fetch("id")
  end

  def url
    @hash.fetch("url")
  end

  def images_original_url
    @hash.fetch("images").fetch("original").fetch("url")
  end
end
