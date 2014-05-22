# encoding: utf-8
require 'feedjira'
class Source < ActiveRecord::Base
  attr_accessible :url, :title, :favicon
  validates_presence_of :url, :title, :source
  validates_uniqueness_of :url
  before_validation :set_source
  before_create :set_favicon
  validate :check_valid_rss
  has_many :entries, :dependent => :destroy

  def fetch_entries
    feed = Feedjira::Feed.fetch_and_parse(url)
    if feed.entries.any?
      feed.entries.each do |entry|
        summary = if entry.summary.nil?
                    ''
                  else
                    Sanitize.clean(entry.summary.lstrip)
                  end
        entries.create(
          title: entry.title,
          url: entry.url,
          description: summary,
          published_at: entry.published)
      end
    end
  end

  searchable do
    string :source
  end

  private

  def set_source
    self.url = "http://#{self.url}" if URI.parse(self.url).scheme.nil?
    host = URI.parse(self.url).host.downcase
    self.source = host.start_with?('www.') ? host[4..-1] : host
  end

  def set_favicon
    self.favicon = "http://#{self.source}/favicon.ico"
  end

  def check_valid_rss
    feed = Feedjira::Feed.fetch_and_parse(self.url)
    errors.add(:url, "в ответ приходит не RSS") if feed.is_a?(Integer)
  end
end

# == Schema Information
#
# Table name: sources
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  source     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  favicon    :string(255)
#
