class City < ActiveRecord::Base
  attr_accessible :title, :slug, :meta_title, :meta_keywords, :meta_description
  has_many :sources
end

# == Schema Information
#
# Table name: cities
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  slug             :string(255)
#  meta_title       :string(255)
#  meta_keywords    :string(255)
#  meta_description :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
