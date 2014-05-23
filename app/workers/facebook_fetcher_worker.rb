class FacebookFetcherWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :facebook_fetcher

  attr_accessor :entry

  def perform(entry_id)
    find_entry(entry_id)
    update_entry_stat
  end

  private

  def find_entry(entry_id)
    @entry ||= Entry.find(entry_id)
  end

  def update_entry_stat
    entry.facebook_shares_count = get_stats(entry.url).first['share_count']
    entry.facebook_comments_count = get_stats(entry.url).first['comment_count']
    entry.facebook_likes_count = get_stats(entry.url).first['like_count']
    entry.facebook_updated_at = Time.zone.now
    entry.save
  end

  def get_stats(url)
    fql = "SELECT url, share_count, like_count, comment_count, total_count FROM link_stat WHERE url='#{url}'"
    fetch_url = "https://api.facebook.com/method/fql.query?format=json&query=#{fql}"
    JSON.parse(open(URI.encode(fetch_url)).read)
  end
end
