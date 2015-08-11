require 'rails_helper'

describe "Blog Post Management", :type => :request do

    let!(:user) {FactoryGirl.create(:user)}
    let!(:blog_post) {FactoryGirl.create(:blog_post, :user_id => user.id)}

    it "displays a list of blog titles" do
      get "/blog_posts"
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include(blog_post.title)
    end

end
