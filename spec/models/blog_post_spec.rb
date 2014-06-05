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

  context "when created_at is nil" do
    it "sets created_at_month to current month" do
      blog_post = FactoryGirl.create(:blog_post)
      blog_post.created_at_month.should == Time.now.month
    end
    it "sets created_at_year to current year" do
      blog_post = FactoryGirl.create(:blog_post)
      blog_post.created_at_year.should == Time.now.year
    end
  end

  context "when created_at is not nil" do
    it "sets created_at month to created_at.month" do
      blog_post = FactoryGirl.create(:blog_post, :created_at => (Time.now - 18.months))
      blog_post.created_at_month.should == blog_post.created_at.month
    end
    it "sets created_at year to created_at.year" do
      blog_post = FactoryGirl.create(:blog_post, :created_at => (Time.now - 18.months))
      blog_post.created_at_year.should == blog_post.created_at.year
    end
  end

end

# == Schema Information
#
# Table name: blog_posts
#
#  id               :integer         not null, primary key
#  title            :text            not null
#  body             :text            not null
#  category_id      :integer
#  user_id          :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  rendered_content :text
#  published        :boolean         default(TRUE), not null
#  slug             :text
#

