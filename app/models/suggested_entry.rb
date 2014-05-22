# encoding: utf-8
require 'open-uri'
class SuggestedEntry < ActiveRecord::Base
  attr_accessible :url, :entry_type, :title
  validates_presence_of :url
  validates_uniqueness_of :url
  validate :check_valid_url

  scope :interesting, where(:entry_type => 'interesting').order('id desc')
  scope :interview, where(:entry_type => 'interview').order('id desc')
  scope :article, where(:entry_type => 'article').order('id desc')

  scope :new_interesting, where(:entry_type => 'new_interesting' )
  scope :new_interview, where(:entry_type => 'new_interview' )
  scope :new_article, where(:entry_type => 'new_article' )

  searchable do
    text :title, :stored => true
    string :entry_type
  end

  def self.available_types
    ["interview", "interesting", "article"]
  end

  def set_title
    entry = Nokogiri::HTML(open(self.url))
    og_title = entry.xpath("//meta[@property='og:title']/@content").text
    title = entry.css("title").text
    self.title = (og_title || title).to_s.force_encoding('iso-8859-1').encode!('utf-8')
    self.save
  end

  def set_favicon
    host = URI.parse(self.url).host.downcase
    source = host.start_with?('www.') ? host[4..-1] : host
    self.favicon = "http://#{source}/favicon.ico"
    self.save
  end

  private
  def check_valid_url
    begin
      Nokogiri.HTML(open(self.url))
    rescue Exception
      errors.add(:url, "невозможно открыть")
    end
  end

end

# == Schema Information
#
# Table name: suggested_entries
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  title      :text
#  entry_type :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
