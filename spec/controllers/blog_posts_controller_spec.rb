require 'spec_helper'

describe BlogPostsController do

  user = User.find_by_email('user@email.com')

  describe "GET #index" do
    it "should redirect to root_path" do
      get :new
      response.code.should == "302"
      response.should redirect_to(root_path)
    end
  end

  describe "GET #show" do
    context "when signed out" do
      context "when post is published" do

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

      context "when post is unpublished" do

        it "assigns nil to blog_post" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          assigns(:blog_post).should eq(nil)
        end

        it "should give 404" do
          blog_post = FactoryGirl.create(:unpublished_blog_post)
          get :show, id: blog_post.id
          response.code.should == "404"
        end

        it "should render the 404 page" do
          blog_post = FactoryGirl.create(:unpublished_blog_post)
          get :show, id: blog_post.id
          response.should render_template("error_404")
        end

      end
    end
  end

  describe "GET #slug" do
    context "when signed out" do
      context "when post is published" do

        it "assigns the requested blog_post to @blog_post" do
          blog_post = FactoryGirl.create(:blog_post)
          get :slug, :slug => blog_post.slug
          assigns(:blog_post).should eq(blog_post)
        end

        it "renders the #show view" do
          get :slug, slug: FactoryGirl.create(:blog_post).slug
          response.should render_template(:show)
        end

      end

      context "when post is unpublished" do

        it "assigns nil to blog_post" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          assigns(:blog_post).should eq(nil)
        end

        it "gives 404" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          response.code.should == "404"
        end

        it "renders the 404 page" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          response.should render_template("error_404")
        end

      end
    end
  end

  describe "GET #new" do
    #need to sign in for this and idk how to do that atm
    context "when signed in" do

      it "assigns a new blog_post to @blog_post" do
        session[:user_id] = user.id
        get :new
        assigns(:blog_post).should be_an_instance_of(BlogPost)
      end
      it "renders the :new view" do
        session[:user_id] = user.id
        get :new
        response.should render_template(:new)
      end
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

        it "creates a blog attachment" do
          session[:user_id] = user.id
          expect{
            post :create, blog_post: FactoryGirl.attributes_for(:blog_post)
          }.to change(BlogAttachment, :count).by(1)
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
