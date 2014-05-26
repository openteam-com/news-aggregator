class Entry < ActiveRecord::Base
  belongs_to :source
  has_many :statistics, :order => 'id desc'
  attr_accessible :title, :url, :description, :published_at
  validates_presence_of :title, :url, :published_at
  validates_uniqueness_of :url
  before_save :default_values

  scope :newest, -> { where('published_at >= :time', {:time => Time.zone.now-12.hour}) }
  scope :today, -> { where('published_at >= :time', {:time => Time.zone.now.beginning_of_day}) }
  scope :threedays, -> { where('published_at >= :time', {:time => Time.zone.now.beginning_of_day - 3.days}) }
  scope :weekly, -> { where('published_at >= :time', {:time => Time.zone.now - 7.days}) }
  scope :monthly, -> { where('published_at >= :time', {:time => Time.zone.now - 30.days}) }
  scope :alltime

  scope :rating, -> { order('rating desc') }
  scope :novelty, -> { order('published_at desc') }

  searchable do
    text :title, :stored => true
    text :description
    string(:source) { source.source }
    float :rating
    time :published_at
  end

  def self.available_periods
    ['newest', 'today', 'threedays', 'weekly', 'monthly', 'alltime']
  end

  def self.available_sorts
    ['rating', 'novelty']
  end

  def stripped_url
    url.sub!(/https\:\/\/www./, '') if url.include? "https://www."
    url.sub!(/http\:\/\/www./, '')  if url.include? "http://www."
    url.sub!(/www./, '')            if url.include? "www."
    url.sub!(/http\:\/\//,'')       if url.include? "http://"
    return url
  end

  def summary_comments_count
    vk_comments_count.to_i + facebook_comments_count.to_i
  end

  def summary_likes_count
    vk_likes_count.to_i + facebook_likes_count.to_i
  end

  def link
    AwayLink.to(url)
  end

  private

  def default_values
    self.url = self.url.strip
    self.vk_shares_count ||= 0
    self.vk_likes_count ||= 0
    self.vk_comments_count ||= 0
    self.facebook_shares_count ||= 0
    self.facebook_comments_count ||= 0
    self.facebook_likes_count ||= 0
    self.twitter_shares_count ||= 0
    update_rating
  end

  def update_rating
    self.rating =
      self.twitter_shares_count +
      self.vk_shares_count +
      self.vk_likes_count*0.5 +
      self.vk_comments_count*0.5 +
      self.facebook_shares_count +
      self.facebook_comments_count*0.5 +
      self.facebook_likes_count*0.5
  end
end

# == Schema Information
#
# Table name: entries
#
#  id                      :integer          not null, primary key
#  title                   :text
#  url                     :string(255)
#  description             :text
#  published_at            :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  rating                  :float            default(0.0)
#  source_id               :integer
#  vk_shares_count         :integer
#  vk_likes_count          :integer
#  vk_comments_count       :integer
#  vk_updated_at           :datetime
#  facebook_shares_count   :integer
#  facebook_comments_count :integer
#  facebook_updated_at     :datetime
#  twitter_shares_count    :integer
#  twitter_updated_at      :datetime
#
