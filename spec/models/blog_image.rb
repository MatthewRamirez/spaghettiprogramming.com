require 'spec_helper'

describe BlogImage do

  it "has a valid factory" do
    FactoryGirl.create(:blog_image).should be_valid
  end

  it "is invalid without a file name" do
    FactoryGirl.build(:blog_image, :image_file_name => nil).should_not be_valid
  end

  it "does not allow duplicate file names" do
    FactoryGirl.create(:blog_image)
    FactoryGirl.build(:blog_image).should_not be_valid
  end


end
