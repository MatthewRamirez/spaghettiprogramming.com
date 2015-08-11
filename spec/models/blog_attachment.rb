require 'spec_helper'

describe BlogAttachment do

  it "has a valid factory" do
    expect(FactoryGirl.create(:blog_attachment)).to be_valid
  end

  it "is invalid without a file name" do
    expect(FactoryGirl.build(:blog_attachment, :file_file_name => nil)).to_not be_valid
  end

  it "does not allow duplicate file names" do
    FactoryGirl.create(:blog_attachment)
    expect(FactoryGirl.build(:blog_attachment)).to_not be_valid
  end


end
