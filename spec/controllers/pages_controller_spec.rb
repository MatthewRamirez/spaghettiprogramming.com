require 'spec_helper'

describe PagesController, type: :controller do

  describe "GET #home" do
    it "populates an array of blog posts" do
      blog_post = FactoryGirl.create(:blog_post)
      get :home
      expect(assigns(:blog_posts)).to eq([blog_post])
    end

    it "renders the blog_posts/index view" do
      get :home
      expect(response).to render_template('blog_posts/index')
    end

    it "renders the application layout" do
      get :home
      expect(response).to render_template(:layout => 'layouts/application')
    end

    it "returns response code 200" do
      get :home
      expect(response.code).to eq('200')
    end

  end

end
