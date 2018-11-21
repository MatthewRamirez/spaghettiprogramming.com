class BlogPost < ApplicationRecord
  require 'redcarpet'
  belongs_to :user

  before_validation :set_slug
  before_save :render_content

  validates_uniqueness_of :slug, :title
  validates_presence_of :slug, :title, :body

  def set_slug
    mslug = slug.blank? ? title : slug
    slug = mslug.gsub(/(#|\$| |-|\/|\.|\(|\)|>|\?)/,'_')
  end

  def self.published
    where("published").order("created_at desc")
  end

  def self.unpublished
    where("not published").order("created_at desc")
  end

  def self.by_id_or_slug(value)
    where("id = ? or slug = ?", value.to_i, value.to_s).last
  end

  private

  def render_content
    renderer = Redcarpet::Render::HTML.new
    extensions = { autolink: true }
    redcarpet = Redcarpet::Markdown.new( renderer, extensions )
    rendered_content = redcarpet.render(body)
  end

end
