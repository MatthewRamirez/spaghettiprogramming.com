class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :blog_posts

  default_scope order('name')

end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :text            not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

