require 'rails_helper'

describe "rendering the home template" do

  it "displays the blog post title" do
    user = FactoryGirl.create(:user)
    blog_post = FactoryGirl.create(:blog_post, :user_id => user.id)
    assign(:blog_posts, [blog_post])

    render :template => "pages/home.html.erb"

    expect(rendered).to match /"#{blog_post.title}"/
  end
end
