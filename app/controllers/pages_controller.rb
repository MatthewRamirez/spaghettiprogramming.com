class PagesController < ApplicationController

  def home
    redirect_to blog_posts_path
  end
end
