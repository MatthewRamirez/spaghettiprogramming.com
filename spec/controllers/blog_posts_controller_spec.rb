require 'spec_helper'

describe BlogPostsController do

  describe "GET #index" do
    it "should redirect to root_path" do
      get :new
      response.code.should == "302"
      response.should redirect_to(root_path)
    end
  end

  describe "GET #show" do
    it "assigns the requested blog_post to @blog_post" do
      blog_post = FactoryGirl.create(:blog_post)
      get :show, :id => blog_post
      assigns(:blog_post).should eq(blog_post)
    end

    it "redirects to blog_slug_path" do
      blog_post = FactoryGirl.create(:blog_post)
      get :show, id: blog_post
      response.code.should == "302"
      response.should redirect_to(blog_slug_path(blog_post.slug))
    end
  end

  describe "GET #slug" do
    context "when signed out" do
      it "assigns the requested blog_post to @blog_post" do
        blog_post = FactoryGirl.create(:blog_post)
        get :slug, :slug => blog_post.slug
        assigns(:blog_post).should eq(blog_post)
      end

      it "renders the #show view" do
        get :slug, slug: FactoryGirl.create(:blog_post).slug
        response.should render_template(:show)
      end

      it "assigns nil if blog_post is unpublished" do
        blog_post = FactoryGirl.create(:blog_post, :published => false)
        get :slug, :slug => blog_post.slug
        assigns(:blog_post).should eq(nil)
      end

      it "redirects to root_path if blog_post is unpublished" do
        blog_post = FactoryGirl.create(:blog_post, :published => false)
        get :slug, :slug => blog_post.slug
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end

  end

  describe "GET #new" do
    #need to sign in for this and idk how to do that atm
    context "when signed in" do
      it "assigns a new blog_post to @blog_post"
      it "renders the :new view"
    end
    context "when signed out" do
      it "should redirect to root_path" do
        get :new
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "when signed in" do
      User.destroy_all
      user = FactoryGirl.create(:user)

      context "with invalid attributes" do
        it "does not save the new blog_post" do
          session[:user_id] = user.id
          expect{
            post :create, blog_post: FactoryGirl.attributes_for(:invalid_blog_post)
          }.to_not change(BlogPost, :count)
        end

        it "renders the :new view" do
          session[:user_id] = user.id
          post :create, blog_post: FactoryGirl.attributes_for(:invalid_blog_post)
          response.should render_template :new
        end
      end

      context "with valid attributes" do
        it "saves the new blog_post" do
          session[:user_id] = user.id
          expect{
            post :create, blog_post: FactoryGirl.attributes_for(:blog_post)
          }.to change(BlogPost, :count).by(1)
        end

        it "redirects to the root path" do
          session[:user_id] = user.id
          post :create, blog_post: FactoryGirl.attributes_for(:blog_post)
          response.should redirect_to root_path
        end
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        post :create
        response.code.should == "302"
        response.should redirect_to(root_path)
      end
    end
  end


end
