require 'progress_bar'

class FacebookFetcher
  def update_newest_stat
    entries = Entry.newest
    pb = ProgressBar.new(entries.count)

    entries.each do |entry|
      update_entry_stat(entry)
      pb.increment!
    end
  end

  def update_older_stat
    entries = Entry.order(:facebook_updated_at).limit(500)
    pb = ProgressBar.new(entries.count)

    entries.each do |entry|
      update_entry_stat(entry)
      pb.increment!
    end
  end

  private

  def update_entry_stat(entry)
    stats = get_stats(entry.url)
    begin
      entry.facebook_shares_count = stats.first['share_count']
      entry.facebook_comments_count = stats.first['comment_count']
      entry.facebook_likes_count = stats.first['like_count']
      entry.facebook_updated_at = Time.zone.now
      entry.save
    rescue
    end
  end

  def get_stats(url)
    fql = "SELECT url, share_count, like_count, comment_count, total_count FROM link_stat WHERE url='#{url}'"
    fetch_url = "https://api.facebook.com/method/fql.query?format=json&query=#{fql}"
    hash = JSON.parse(open(URI.encode(fetch_url)).read)
  end
end
