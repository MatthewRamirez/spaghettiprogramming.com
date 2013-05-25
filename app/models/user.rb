class User < ActiveRecord::Base
  attr_accessible :email_address, :identifier_url, :nick, :uid, :provider

  has_many :blog_posts

  def self.create_from_auth(user_params)
    create!(user_params)
  end
end

# == Schema Information
#
# Table name: users
#
#  id             :integer         not null, primary key
#  email_address  :text            not null
#  identifier_url :text
#  nick           :text
#  uid            :text
#  provider       :text
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

