class TwitterFetcher
  include Sidekiq::Worker

  def initialize
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = Settings['twitter.consumer_key']
      config.consumer_secret     = Settings['twitter.consumer_secret']
      config.access_token        = Settings['twitter.access_token']
      config.access_token_secret = Settings['twitter.access_token_secret']
    end
  end

  def self.limit
    170
  end

  def update_stat
    newest_entries = Entry.newest.where('twitter_updated_at IS NULL OR twitter_updated_at < ?', Time.zone.now - 2.hour).limit(TwitterFetcher.limit)
    last_updated_entries = Entry.order(:twitter_updated_at).limit(TwitterFetcher.limit - newest_entries.count)
    (newest_entries + last_updated_entries).each do |entry|
      update_entry_stat(entry)
    end
  end

  def update_entry_stat(entry)
    entry.twitter_shares_count = @twitter.search(entry.stripped_url).count
    entry.twitter_updated_at = Time.zone.now
    entry.save
  end

end
