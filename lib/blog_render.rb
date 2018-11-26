class BlogRender < Redcarpet::Render::HTML
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'
  # Custom renderer for Markdown syntax
  include Rouge::Plugins::Redcarpet
end
