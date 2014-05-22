class BlogImage < ActiveRecord::Base
  belongs_to :blog_post
  attr_accessible :image
  default_scope { order('image_updated_at desc') }
  has_attached_file :image, {
    :whiny => true,
    :url => "/system/:class/:style/:filename",
    :hash_data => nil,
    :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }
  }
  validates_uniqueness_of :image_file_name
  validates_presence_of :image_file_name
end

# == Schema Information
#
# Table name: blog_images
#
#  id                 :integer         not null, primary key
#  blog_post_id       :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

