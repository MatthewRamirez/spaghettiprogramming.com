class BlogPostsController < ApplicationController

  before_action :redirect_to_root_unless_signed_in, :except => [ :index, :show ]

  def index
    @blog_posts = BlogPost.published.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @blog_post = signed_in? ? BlogPost.by_id_or_slug(params[:id]) : BlogPost.published.by_id_or_slug(params[:id])
  end

  def new
    @title = 'New Blog Post'
    @blog_post = BlogPost.new({ :published => false })
  end

  def create
    @blog_post = BlogPost.create(blog_post_params)
    @blog_post.valid? ? redirect_to(root_path) : render(:new)
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
    params[:blog_post][:user_id] = current_user.id
    params.require(:blog_post).permit(:title, :body, :user_id, :published, :slug, :user_id)
  end

end
