require 'spec_helper'

describe BlogPost do
  it "has a valid factory" do
    expect(FactoryGirl.create(:blog_post)).to be_valid
  end

  it "has a slug if none given" do
    expect(FactoryGirl.build(:blog_post, :slug => nil)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:blog_post, :title => nil)).to_not be_valid
  end

  it "is invalid without a body" do
    expect(FactoryGirl.build(:blog_post, :body => nil)).to_not be_valid
  end

  it "does not allow duplicate titles" do
    FactoryGirl.create(:blog_post, :title => 'Dupe', :slug => 'Dupe')
    expect(FactoryGirl.build(:blog_post, :title => 'Dupe', :slug => 'Not a dupe')).to_not be_valid
  end

  it "does not allow duplicate slugs" do
    FactoryGirl.create(:blog_post, :slug => 'Dupe', :title => 'Dupe')
    expect(FactoryGirl.build(:blog_post, :slug => 'Dupe', :title => 'Not a dupe')).to_not be_valid
  end

  it "can be instantiated" do
    expect(FactoryGirl.build(:blog_post)).to be_an_instance_of(BlogPost)
  end

  it "can be saved successfully" do
    expect(FactoryGirl.create(:blog_post)).to be_persisted
  end

  context "when created_at is nil" do
    it "sets created_at_month to current month" do
      blog_post = FactoryGirl.create(:blog_post)
      expect(blog_post.created_at_month).to eq(Time.now.month)
    end
    it "sets created_at_year to current year" do
      blog_post = FactoryGirl.create(:blog_post)
      expect(blog_post.created_at_year).to eq(Time.now.year)
    end
  end

  context "when created_at is not nil" do
    it "sets created_at month to created_at.month" do
      blog_post = FactoryGirl.create(:blog_post, :created_at => (Time.now - 18.months))
      expect(blog_post.created_at_month).to eq(blog_post.created_at.month)
    end
    it "sets created_at year to created_at.year" do
      blog_post = FactoryGirl.create(:blog_post, :created_at => (Time.now - 18.months))
      expect(blog_post.created_at_year).to eq(blog_post.created_at.year)
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
#  created_at       :datetime
#  updated_at       :datetime
#  rendered_content :text
#  published        :boolean         default(TRUE), not null
#  slug             :text
#  created_at_month :integer
#  created_at_year  :integer
#

