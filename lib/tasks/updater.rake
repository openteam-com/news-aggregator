namespace :update do

  desc 'Update rss'
  task :rss => :environment do
    Source.all.map { |c| c.delay.fetch_entries }
  end

  desc 'Update newest entries statistics'
  task :stat_newest_entries => :environment do
    VkFetcher.new.update_newest_stat
    FacebookFetcher.new.update_newest_stat
  end

  desc 'Update twitter statistics'
  task :twitter_stat => :environment do
    TwitterFetcher.new.update_stat
  end

  desc 'Update vkontakte and facebook statistics'
  task :vk_and_facebook_stat => :environment do
    VkFetcher.new.update_older_stat
    FacebookFetcher.new.update_older_stat
  end
end
