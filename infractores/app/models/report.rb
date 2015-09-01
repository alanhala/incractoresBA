class Report < ActiveRecord::Base
  scope :valid_reports, -> { where(is_valid: true) }
  belongs_to :user

  def tweet_to_invalid_report(tweet)
    TWITTER.update("@#{tweet.user.screen_name} Para reportar un infractor,"\
                   "necesitas una imagen y geolocalizar el tweet. Para mas"\
                   "informacion: http://placeholder.com", in_reply_to_status: tweet)
  end

  def valid_report?
    self.latitude && self.longitude
  end
end
