require 'rails_helper'

describe BlogPostsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:blog_post) }

  describe "GET #index" do
    it "should redirect to root_path" do
      get :index
      expect(response.code).to eq("302")
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #unpublished_index" do
    context "when signed out" do
      it "should redirect to root_path" do
        get :unpublished_index
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
    context "when signed in" do
      it "should render the unpublished index" do
        session[:user_id] = user.id
        get :unpublished_index
        expect(response).to render_template("unpublished_index")
      end
    end
  end

  describe "GET #show" do
    context "when signed out" do
      context "when post is published" do

        it "assigns the requested blog_post to @blog_post" do
          get :show, :id => blog_post
          expect(assigns(:blog_post)).to eq(blog_post)
        end

        it "redirects to blog_slug_path" do
          get :show, id: blog_post
          expect(response.code).to eq("302")
          expect(response).to redirect_to(blog_slug_path(blog_post.slug))
        end
      end

      context "when post is unpublished" do

        it "assigns nil to blog_post" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          expect(assigns(:blog_post)).to eq(nil)
        end

        it "should give 404" do
          blog_post = FactoryGirl.create(:unpublished_blog_post)
          get :show, id: blog_post.id
          expect(response.code).to eq("404")
        end

        it "should render the 404 page" do
          blog_post = FactoryGirl.create(:unpublished_blog_post)
          get :show, id: blog_post.id
          expect(response).to render_template("error_404")
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
          expect(assigns(:blog_post)).to eq(blog_post)
        end

        it "renders the #show view" do
          get :slug, slug: FactoryGirl.create(:blog_post).slug
          expect(response).to render_template(:show)
        end

      end

      context "when post is unpublished" do

        it "assigns nil to blog_post" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          expect(assigns(:blog_post)).to eq(nil)
        end

        it "gives 404" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          expect(response.code).to eq("404")
        end

        it "renders the 404 page" do
          blog_post = FactoryGirl.create(:blog_post, :published => false)
          get :slug, :slug => blog_post.slug
          expect(response).to render_template("error_404")
        end

      end
    end
  end

  describe "GET #new" do
    context "when signed in" do
      it "assigns a new blog_post to @blog_post" do
        session[:user_id] = user.id
        get :new
        expect(assigns(:blog_post)).to be_an_instance_of(BlogPost)
      end
      it "renders the :new view" do
        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        get :new
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
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
          expect(response).to render_template :new
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
          expect(response).to redirect_to root_path
        end
      end
    end
    context "when signed out" do
      it "should redirect to root_path" do
        post :create
        expect(response.code).to eq("302")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #archive" do
    context "when an archive month has posts" do
      it "renders the index template" do
        get :archive, id: "#{blog_post.created_at_year.to_s + blog_post.created_at_month.to_s}"
        expect(response).to render_template('index')
      end
    end
    context "when an archive month is empty" do
      it "renders the empty archive template" do
        get :archive, id: 000000
        expect(response).to render_template('no_posts_in_archive')
      end
    end
  end

end
