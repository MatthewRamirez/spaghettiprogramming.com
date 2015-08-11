require 'spec_helper'

describe Category do
  it "has a valid factory" do
    expect(FactoryGirl.create(:category)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:category, :name => nil)).to_not be_valid
  end

  it "does not allow duplicate names" do
    FactoryGirl.create(:category)
    expect(FactoryGirl.build(:category)).to_not be_valid
  end

  it "can be instantiated" do
    expect(FactoryGirl.build(:category)).to be_an_instance_of(Category)
  end

  it "can be saved successfully" do
    expect(FactoryGirl.create(:category)).to be_persisted
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

