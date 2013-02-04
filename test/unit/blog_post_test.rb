require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: blog_posts
#
#  id               :integer         not null, primary key
#  title            :text            not null
#  body             :text            not null
#  category_id      :integer
#  user_id          :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  rendered_content :text
#  published        :boolean         default(TRUE), not null
#

