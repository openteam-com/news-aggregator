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

  def update_all
    entries = Entry.all
    pb = ProgressBar.new(entries.count)

    entries.each do |entry|
      update_entry_stat(entry)
      pb.increment!
    end
  end

  private

  def update_entry_stat(entry)
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
