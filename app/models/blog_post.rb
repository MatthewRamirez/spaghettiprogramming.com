class BlogPost < ActiveRecord::Base
  default_scope order('created_at desc')
  belongs_to :user
  belongs_to :category
  has_many :blog_images

  accepts_nested_attributes_for :blog_images, :allow_destroy => true
  attr_accessible :title, :body, :user_id, :category_id, :published,
    :blog_images_attributes, :blog_images_array

  before_save :render_content

  def blog_images_array=(array)
    array.each do |file|
      self.blog_images.build(:image => file)
    end
  end

  def self.published
    where :published => true
  end

  def self.unpublished
    where :published => false
  end

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
#  published        :boolean         default(TRUE), not null
#

