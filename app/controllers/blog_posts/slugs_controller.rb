class BlogPosts::SlugsController < ApplicationController

  def show
    @blog_post = signed_in? ? BlogPost.find_by_slug(params[:slug]) : BlogPost.published.find_by_slug(params[:slug])
    @blog_post.nil? ? not_found : @title = @blog_post.title
    render 'blog_posts/show'
  end

end
