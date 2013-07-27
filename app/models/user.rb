class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :identifier_url, :nick

  has_many :blog_posts

  validates_presence_of :password, :on => :create
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false },
  :length => { :maximum => 100 }

  def self.create_from_auth(user_params)
    create!(user_params)
  end

  def self.new_random_password(string)
    Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{string}--")[0,12]
  end

  def reset_password
    password_string = User.new_random_password(email)
    update_attributes!(:password => password_string, :password_confirmation => password_string)
    return password_string
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

