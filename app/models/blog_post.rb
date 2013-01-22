class BlogPost < ActiveRecord::Base
  default_scope order('created_at desc')
  belongs_to :user
  belongs_to :category

  attr_accessible :title, :body, :user_id, :category_id

  before_save :render_content

  private
  def render_content
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = { autolink: true }
    redcarpet = Redcarpet::Markdown.new( renderer, extensions )
    self.rendered_content = redcarpet.render self.body
  end
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
#

