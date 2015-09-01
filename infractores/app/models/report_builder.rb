class ReportBuilder

  def self.create_reports(tweets)
    tweets.each do |tweet|
      params_tweet = self.tweet_params(tweet)
      user = User.create_or_update_name(tweet.user)
      params_tweet[:user_id] = user.id
      report = Report.create(params_tweet)
      if report.valid_report?
        report.update_attribute(:is_valid, true)
      else
        report.tweet_to_invalid_report(tweet)
      end
    end
  end

  def self.tweet_params(tweet)
    params = {}
    params[:tweet_id] = tweet.id
    params[:latitude] = tweet.geo.coordinates.first
    params[:longitude] = tweet.geo.coordinates.last
    params[:post] = tweet.text
    return params
  end
end
