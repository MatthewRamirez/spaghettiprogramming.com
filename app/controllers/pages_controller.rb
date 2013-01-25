class PagesController < ApplicationController

  def home
    @blog_posts = BlogPost.limit 5
  end
end
