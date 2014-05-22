class VkFetcher
  include Sidekiq::Worker

  def initialize
    @vk = VkontakteApi::Client.new
  end

  def update_newest_stat
    Entry.newest.each do |entry|
      update_entry_stat(entry)
    end
  end

  def update_older_stat
    Entry.order(:vk_updated_at).limit(500).each do |entry|
      update_entry_stat(entry)
    end
  end

  def update_entry_stat(entry)
    vk_search = @vk.newsfeed.search(q: "url:"+entry.url)
    vk_likes_count = vk_comments_count = 0
    for i in 1..vk_search.count - 1 # while post
      vk_likes_count += vk_search[i].likes["count"] unless vk_search[i].nil?
      vk_comments_count += vk_search[i].comments["count"] unless vk_search[i].nil?
    end
    entry.vk_shares_count = vk_search.count - 1
    entry.vk_likes_count = vk_likes_count
    entry.vk_comments_count = vk_comments_count
    entry.vk_updated_at = Time.zone.now
    entry.save
  end
end
