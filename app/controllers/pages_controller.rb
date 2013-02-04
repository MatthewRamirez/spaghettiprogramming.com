class PagesController < ApplicationController

  def home
    @blog_posts = BlogPost.published.limit 5
  end
end
