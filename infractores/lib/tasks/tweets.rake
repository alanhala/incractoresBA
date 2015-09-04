# encoding: utf-8

namespace :tweets do
  desc "Load new mentions"
  task load_tweets: :environment do
    mentions = load_mentions(Report.from_mention.first)
    search = load_search(Report.from_hashtag.first)
    ReportBuilder.create_reports(mentions, "mention")
    ReportBuilder.create_reports(search, "search")
  end

  def load_mentions(last_report = nil)
    if last_report
      TWITTER.mentions({ since_id: last_report.tweet_id })
    else
      TWITTER.mentions
    end
  end

  def load_search(last_report = nil)
    hashtags = []
    if last_report
      search = TWITTER.search("#infractoresba", { since_id: last_report.tweet_id })
    else
      search = TWITTER.search("#infractoresba")
    end
    search.each do |tweet|
      hashtags << tweet
    end
    return hashtags
  end
end
