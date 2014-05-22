class BlogAttachment < ActiveRecord::Base
  belongs_to :blog_post
  attr_accessible :file
  default_scope { order('file_updated_at desc') }
  has_attached_file :file, {
    :whiny => true,
    :url => "/system/:class/:filename",
    :hash_data => nil,
    :styles => { }
  }
  validates_uniqueness_of :file_file_name
  validates_presence_of :file_file_name
end

# == Schema Information
#
# Table name: blog_attachments
#
#  id                :integer         not null, primary key
#  blog_post_id      :integer
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

