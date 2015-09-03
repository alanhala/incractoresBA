# encoding: utf-8

namespace :tweets do
  desc "Load new mentions"
  task load_tweets: :environment do
    if !!Report.last
      tweets = TWITTER.mentions_timeline({ since_id: Report.first.tweet_id })
    else
      tweets = TWITTER.mentions_timeline
    end
    ReportBuilder.create_reports(tweets)
  end
end
