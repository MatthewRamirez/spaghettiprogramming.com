class BlogPost < ActiveRecord::Base
  default_scope { order('created_at desc') }
  belongs_to :user
  belongs_to :category
  has_many :blog_images
  has_many :blog_attachments

  accepts_nested_attributes_for :blog_images, :allow_destroy => true
  accepts_nested_attributes_for :blog_attachments, :allow_destroy => true
  attr_accessible :title, :body, :user_id, :category_id, :published,
    :blog_images_attributes, :blog_images_array, :slug,
    :blog_attachments_attributes, :blog_attachments_array

  before_validation :slugify
  before_save :render_content

  validates_uniqueness_of :slug, :title
  validates_presence_of :slug, :title, :body

  def blog_attachments_array=(array)
    array.each do |attachment|
      self.blog_attachments.build(:file => attachment)
    end
  end

  def blog_images_array=(array)
    array.each do |file|
      self.blog_images.build(:image => file)
    end
  end

  def slugify
    mslug = self.slug.blank? ? self.title : self.slug
    self.slug = mslug.gsub(/(#|\$| |-|\/|\.|\(|\)|>|\?)/,'_')
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
#  slug             :text
#

