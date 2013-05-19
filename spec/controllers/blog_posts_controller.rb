require 'spec_helper'

describe BlogPostsController do

  describe "GET #index" do
    it "populates an array of blog posts"
    it "renders the :index view"
  end

  describe "GET #show" do
    it "assigns the requested blog_post to @blog_post"
    it "renders the :show view"
  end

  describe "GET #new" do
    it "assigns a new blog_post to @blog_post"
    it "renders the :new view"
  end

  describe "POST #create" do
    context "with invalid attributes" do
      it "does not save the new blog_post"
      it "renders the :new view"
    end
    context "with valid attributes" do
      it "saves the new blog_post"
      it "redirects to the show page"
    end
  end


end
