class Category < ActiveRecord::Base
  has_many :blog_posts

  validates_presence_of :name
  validates_uniqueness_of :name

  default_scope { order('name') }

end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :text            not null
#  created_at :datetime
#  updated_at :datetime
#

