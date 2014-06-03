class BlogPostsController < ApplicationController
  include ApplicationHelper

  before_filter :redirect_to_root_unless_signed_in, :except => [ :index, :slug, :show ]

  def index
    redirect_to root_path
  end

  def unpublished_index
    @title = "Unpublished Blog Posts"
    @blog_posts = BlogPost.unpublished.paginate(:page => params[:page], :per_page => 20)
    render 'blog_posts/unpublished_index'
  end

  def show
    @blog_post = signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find_by_id(params[:id])
    @blog_post.nil? ? not_found : redirect_to(blog_slug_path(@blog_post.slug))
  end

  def slug
    @blog_post = signed_in? ? BlogPost.find_by_slug(params[:slug]) : BlogPost.published.find_by_slug(params[:slug])
    @blog_post.nil? ? not_found : @title = @blog_post.title
    render 'blog_posts/show'
  end

  def new
    @title = 'New Blog Post'
    @blog_post = BlogPost.new({ :published => false })
    @categories = Category.all
    @blog_images = []
    @blog_attachments = []
  end

  def create
    @categories = Category.all
    @blog_images = []
    @blog_attachments = []
    @blog_post = current_user.blog_posts.build(blog_post_params)
    @blog_post.save ? redirect_to(root_path) : render(:new)
  end

  def edit
    @title = 'Edit Blog Post'
    @blog_post = BlogPost.find params[:id]
    @categories = Category.all
    @blog_images = @blog_post.blog_images
    @blog_attachments = @blog_post.blog_attachments
  end

  def update
    @blog_post = BlogPost.find params[:id]
    @blog_post.update_attributes(blog_post_params) ? redirect_to(@blog_post) : render('edit')
  end

  def destroy
    @blog_post = BlogPost.find params[:id]
    if @blog_post.destroy
      redirect_to blog_posts_path
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit( :title, :body, :user_id, :category_id, :published, :slug,
      {:blog_images_attributes => [:id, :blog_post_id, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :_destroy]},
      {:blog_images_array => []},
      {:blog_attachments_attributes => [:id, :blog_post_id, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :_destroy]},
      {:blog_attachments_array => []})
  end

end
