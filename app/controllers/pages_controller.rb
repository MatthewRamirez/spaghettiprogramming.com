class PagesController < ApplicationController

  def home
    @blog_posts = BlogPost.all
  end
end
