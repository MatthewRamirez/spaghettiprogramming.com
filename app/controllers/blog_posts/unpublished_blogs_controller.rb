class BlogPosts::UnpublishedBlogsController < ApplicationController

  before_filter :redirect_to_root_unless_signed_in

  def index
    @blog_posts = BlogPost.published.paginate(:page => params[:page], :per_page => 5)
    render 'blog_posts/index'
  end

end
