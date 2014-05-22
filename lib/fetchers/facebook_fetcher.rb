class FacebookFetcher
  include Sidekiq::Worker

  def initialize
    @facebook = Koala::Facebook::GraphAPI.new(Settings['facebook.access_token'], Settings['facebook.access_token_secret'])
  end

  def update_newest_stat
    Entry.newest.each do |entry|
      update_entry_stat(entry)
    end
  end

  def update_older_stat
    Entry.order(:facebook_updated_at).limit(500).each do |entry|
      update_entry_stat(entry)
    end
  end

  def update_entry_stat(entry)
    facebook_search = @facebook.get_objects(entry.url)[entry.url]
    entry.facebook_shares_count = facebook_search['shares']
    entry.facebook_comments_count = facebook_search['comments']
    entry.facebook_updated_at = Time.zone.now
    entry.save
  end
end
