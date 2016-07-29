class TweetAdapter

  def initialize(tweet)
    @tweet = tweet
  end

  def valid?
    !self.latitude.nil? && !self.longitude.nil? && self.has_images?
  end

  def latitude
    @tweet.geo.coordinates.first
  end

  def longitude
    @tweet.geo.coordinates.last
  end

  def id
    @tweet.id
  end

  def post
    @tweet.text
  end

  def has_images?
    !self.images.empty?
  end

  def images
    @tweet.media.select{ |media| media.instance_of?(Twitter::Media::Photo) }
  end

  def user
    @tweet.user
  end
end
