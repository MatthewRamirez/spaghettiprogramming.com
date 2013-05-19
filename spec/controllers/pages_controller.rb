require 'spec_helper'

describe PagesController do

  describe "GET #home" do
    it "populates an array of blog posts" do
      blog_post = FactoryGirl.create(:blog_post)
      get :home
      assigns(:blog_posts).should eq([blog_post])
    end

    it "renders the blog_posts/index view" do
      get :home
      response.should render_template('blog_posts/index')
    end
  end

end
