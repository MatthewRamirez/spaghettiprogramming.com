class BlogPostsController < ApplicationController
  include ApplicationHelper

  before_filter :redirect_to_root_unless_signed_in, :except => [ :index, :show ]

  def index
    @title = "Blog Posts"
    if params.has_key? :category_id
      @category = Category.find params[:category_id]
      @blog_posts = @category.blog_posts
    else
      @blog_posts = BlogPost.all
    end
  end

  def show
    @blog_post = BlogPost.find params[:id]
  end

  def new
    @blog_post = BlogPost.new
    @categories = Category.all
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
