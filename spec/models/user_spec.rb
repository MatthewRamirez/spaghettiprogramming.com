require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, :email => nil).should_not be_valid
  end

  it "does not allow duplicate emails" do
    FactoryGirl.create(:user)
    FactoryGirl.build(:user).should_not be_valid
  end

  it "can be instantiated" do
    FactoryGirl.build(:user).should be_an_instance_of(User)
  end

  it "can be saved successfully" do
    FactoryGirl.create(:user).should be_persisted
  end

end

# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :text            not null
#  identifier_url  :text
#  nick            :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :text
#

