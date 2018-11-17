class PagesController < ApplicationController
  include ShowStatic

  def home
    @blog_posts = BlogPost.published.paginate(:page => params[:page], :per_page => 5)
    render 'blog_posts/index'
  end
end
