require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, :email => nil)).to_not be_valid
  end

  it "does not allow duplicate emails" do
    FactoryGirl.create(:user)
    expect(FactoryGirl.build(:user)).to_not be_valid
  end

  it "can be instantiated" do
    expect(FactoryGirl.build(:user)).to be_an_instance_of(User)
  end

  it "can be saved successfully" do
    expect(FactoryGirl.create(:user)).to be_persisted
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
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :text
#

