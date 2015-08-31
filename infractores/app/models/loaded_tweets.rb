class LoadedTweets

  def self.create_reports(tweets)
    tweets.each do |tweet|
      user = User.find_or_create_by(account_id: tweet.user.id)
      params_tweet = self.tweet_params(tweet)
      params_tweet[:user_id] = user.id
      Report.create(params_tweet)
    end
  end

  def self.tweet_params(tweet)
    params = {}
    params[:post] = tweet.text
    return params
  end
end
