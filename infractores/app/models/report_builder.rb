class ReportBuilder

  def self.create_reports(tweets)
    tweets.each do |tweet|
      adapted_tweet = TweetAdapter.new(tweet)
      if adapted_tweet.valid?
        self.create_valid_report(adapted_tweet)
      else
        self.create_invalid_report(adapted_tweet)
      end
    end
  end

  def self.create_valid_report(tweet)
    user = User.create_or_update_name(tweet.user)
    report = create_base_report(tweet)
    report.save!
    report.attach_images(tweet)
    report.update_attributes(is_valid: true, user_id: user.id)
  end

  def self.create_invalid_report(tweet)
    report = create_base_report(tweet)
    report.save!
    #   report.tweet_to_invalid_report(tweet)
  end

  def self.create_base_report(tweet)
    Report.new(self.tweet_params(tweet))
  end

  def self.tweet_params(tweet)
    params = {}
    params[:tweet_id] = tweet.id
    params[:latitude] = tweet.latitude
    params[:longitude] = tweet.longitude
    params[:post] = tweet.post
    return params
  end
end
