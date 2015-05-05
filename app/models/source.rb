# encoding: utf-8
require 'feedjira'

class Source < ActiveRecord::Base
  extend Enumerize

  attr_accessible :url, :title, :favicon, :city

  validate :check_valid_rss
  validates_presence_of :url, :title, :source, :city
  validates_uniqueness_of :url

  before_validation :set_source
  before_create :set_favicon
  after_save :reindex_entries

  has_many :entries, :dependent => :destroy

  enumerize :city, :in => [:tomsk, :sevastopol], :predicates => true

  city.values.each do |method_name|
    self.class.send :define_method,  method_name do
      where(:city => method_name)
    end
  end

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

  def reindex_entries
    entries.map { |m| m.delay.index }
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
#  city       :string(255)
#
