every 1.hour do
  rake "update:rss", :output => "log/cron.log"
  rake "update:stat_newest_entries", :output => "log/cron.log"
end

every 6.hour do
  rake "update:vk_and_facebook_stat", :output => "log/cron.log"
end

every 30.minutes do
  rake "update:twitter_stat", :output => "log/cron.log"
end
