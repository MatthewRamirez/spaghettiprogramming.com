class BlogPostsController < ApplicationController

  before_filter :redirect_to_root_unless_signed_in, :except => [ :index, :slug, :show ]

  def index
    redirect_to root_path
  end

  def show
    @blog_post = signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find_by_id(params[:id])
    @blog_post.nil? ? not_found : redirect_to(blog_slug_path(@blog_post.slug))
  end

  def new
    @title = 'New Blog Post'
    @blog_post = BlogPost.new({ :published => false })
  end

  def create
    BlogPost.create(blog_post_params) ? redirect_to(root_path) : render(:new)
  end

  def edit
    @title = 'Edit Blog Post'
    @blog_post = BlogPost.find params[:id]
  end

  def update
    @blog_post = BlogPost.find params[:id]
    @blog_post.update_attributes(blog_post_params) ? redirect_to(@blog_post) : render('edit')
  end

  def destroy
    @blog_post = BlogPost.find params[:id]
    @blog_post.destroy
    redirect_to(redirection_path_after_delete(request.referrer))
  end

  private

  def redirection_path_after_delete(referrer = '/')
    return referrer =~ /#{@blog_post.slug}/ ? '/' : referrer
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :user_id, :published, :slug)
  end

end
