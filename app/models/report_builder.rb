class ReportBuilder

  def self.create_reports(tweets, source)
    tweets.each do |tweet|
      adapted_tweet = TweetAdapter.new(tweet)
      report = self.find_or_initialize_base_report(adapted_tweet, source)
      return if !report.new_record?
      if adapted_tweet.valid?
        self.create_valid_report(adapted_tweet, report)
      else
        report.save
        # report.tweet_to_invalid_report(tweet)
      end
    end
  end

  def self.create_valid_report(tweet, report)
    user = User.create_or_update_name(tweet.user)
    report.save
    report.attach_images(tweet)
    report.update_attributes(is_valid: true, user_id: user.id)
  end

  def self.find_or_initialize_base_report(tweet, source)
    # Report.new(self.tweet_params(tweet))
    Report.create_with(self.tweet_params(tweet, source)).find_or_initialize_by(tweet_id: tweet.id)
  end

  def self.tweet_params(tweet, source)
    params = {}
    params[:tweet_id] = tweet.id
    params[:latitude] = tweet.latitude
    params[:longitude] = tweet.longitude
    params[:post] = tweet.post
    params[:source] = source
    return params
  end
end
