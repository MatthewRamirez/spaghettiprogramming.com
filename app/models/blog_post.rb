class BlogPost < ActiveRecord::Base
  default_scope { order('created_at desc') }
  belongs_to :user
  belongs_to :category
  has_many :blog_images
  has_many :blog_attachments

  accepts_nested_attributes_for :blog_images, :allow_destroy => true
  accepts_nested_attributes_for :blog_attachments, :allow_destroy => true

  before_validation :slugify
  before_save :render_content
  before_save :set_created_at_month_and_year

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

  def self.archive(archive_slug)
    year = archive_slug.slice(0,4).to_i
    month = archive_slug.slice(4,2).to_i
    if month == 12
      where( "created_at_year < ? and created_at_month = 1 and created_at_year >= ? and created_at_month >= ? and published",
        (year + 1), year, month)
    else
      where( "created_at_year <= ? and created_at_month < ? and created_at_year >= ? and created_at_month >= ? and published",
        year, (month + 1), year, month)
    end
  end

  def set_created_at_month_and_year
   self.created_at_month = self.created_at.month
   self.created_at_year = self.created_at.year
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

