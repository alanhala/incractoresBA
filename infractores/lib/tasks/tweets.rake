# encoding: utf-8

namespace :tweets do
  desc "Load new mentions"
  task load_tweets: :environment do
    LoadedTweets.create_reports(TWITTER.mentions_timeline)
  end
end
