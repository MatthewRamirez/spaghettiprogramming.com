require 'spec_helper'

describe BlogAttachment do

  it "has a valid factory" do
    FactoryGirl.create(:blog_attachment).should be_valid
  end

  it "is invalid without a file name" do
    FactoryGirl.build(:blog_attachment, :file_file_name => nil).should_not be_valid
  end

  it "does not allow duplicate file names" do
    FactoryGirl.create(:blog_attachment)
    FactoryGirl.build(:blog_attachment).should_not be_valid
  end


end
