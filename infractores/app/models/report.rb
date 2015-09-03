class Report < ActiveRecord::Base
  scope :valid_reports, -> { where(is_valid: true) }
  has_many :images
  belongs_to :user

  def tweet_to_invalid_report(tweet)
    TWITTER.update("@#{tweet.user.screen_name} Para reportar un infractor,"\
                   "necesitas una imagen y geolocalizar el tweet. Para mas"\
                   "informacion: http://placeholder.com", in_reply_to_status: tweet)
  end

  def attach_images(tweet)
    urls = get_images_url(tweet)
    urls.each do |url|
      self.images.build(remote_attachment_url: url.to_s)
    end
  end

  def get_images_url(tweet)
    return tweet.images.map(&:media_url)
  end
end
