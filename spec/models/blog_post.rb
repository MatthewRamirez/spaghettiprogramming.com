require 'spec_helper'

describe BlogPost do
  it "has a valid factory" do
    FactoryGirl.create(:blog_post).should be_valid
  end

  it "has a slug if none given" do
    FactoryGirl.build(:blog_post, :slug => nil).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:blog_post, :title => nil).should_not be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:blog_post, :body => nil).should_not be_valid
  end

  it "does not allow duplicate titles" do
    FactoryGirl.create(:blog_post, :title => 'Dupe', :slug => 'Dupe')
    FactoryGirl.build(:blog_post, :title => 'Dupe', :slug => 'Not a dupe').should_not be_valid
  end

  it "does not allow duplicate slugs" do
    FactoryGirl.create(:blog_post, :slug => 'Dupe', :title => 'Dupe')
    FactoryGirl.build(:blog_post, :slug => 'Dupe', :title => 'Not a dupe').should_not be_valid
  end

  it "can be instantiated" do
    FactoryGirl.build(:blog_post).should be_an_instance_of(BlogPost)
  end

  it "can be saved successfully" do
    FactoryGirl.create(:blog_post).should be_persisted
  end

end
