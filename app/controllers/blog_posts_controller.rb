class BlogPostsController < ApplicationController
  include ApplicationHelper

  before_filter :redirect_to_root_unless_signed_in, :except => [ :index, :slug, :show ]

  def index
    redirect_to root_path
  end

  def unpublished_index
    redirect_to root_path and return unless signed_in?
    @title = "Unpublished Blog Posts"
    if params.has_key? :category_id
      @category = Category.find params[:category_id]
      @blog_posts = @category.blog_posts.unpublished.paginate(:page => params[:page], :per_page => 5)
    else
      @blog_posts = BlogPost.unpublished.paginate(:page => params[:page], :per_page => 5)
      render 'blog_posts/index'
    end
  end

  def show
    @blog_post = signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    redirect_to blog_slug_path(@blog_post.slug)
  end

  def slug
    @blog_post = signed_in? ? BlogPost.find_by_slug(params[:slug]) : BlogPost.published.find_by_slug(params[:slug])
    render 'blog_posts/show'
  end

  def new
    @blog_post = BlogPost.new
    @categories = Category.all
    @blog_images = []
  end

  def create
    post = current_user.blog_posts.build params[:blog_post]
    if post.save
      redirect_to blog_posts_path
    end
  end

  def edit
    @blog_post = BlogPost.find params[:id]
    @categories = Category.all
    @blog_images = @blog_post.blog_images
  end

  def update
    @blog_post = BlogPost.find params[:id]
    if @blog_post.update_attributes params[:blog_post]
      redirect_to @blog_post
    else
      render 'edit'
    end
  end

  def destroy
    @blog_post = BlogPost.find params[:id]
    if @blog_post.destroy
      redirect_to blog_posts_path
    end
  end

end
