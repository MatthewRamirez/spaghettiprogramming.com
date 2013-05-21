require 'spec_helper'

describe BlogAttachment do
  pending "add some examples to (or delete) #{__FILE__}"
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

