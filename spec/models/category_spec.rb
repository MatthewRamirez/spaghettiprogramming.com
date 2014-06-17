require 'spec_helper'

describe Category do
  it "has a valid factory" do
    FactoryGirl.create(:category).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:category, :name => nil).should_not be_valid
  end

  it "does not allow duplicate names" do
    FactoryGirl.create(:category)
    FactoryGirl.build(:category).should_not be_valid
  end

  it "can be instantiated" do
    FactoryGirl.build(:category).should be_an_instance_of(Category)
  end

  it "can be saved successfully" do
    FactoryGirl.create(:category).should be_persisted
  end

end


# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :text            not null
#  created_at :datetime
#  updated_at :datetime
#

