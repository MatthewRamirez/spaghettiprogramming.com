class User < ApplicationRecord
  has_secure_password
  has_many :blog_posts

  validates_presence_of :password, :on => :create
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false },
  :length => { :maximum => 100 }

  def self.new_random_password(string)
    Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{string}--")[0,12]
  end

  def reset_password
    password_string = User.new_random_password(email)
    update_attributes!(:password => password_string, :password_confirmation => password_string)
    return password_string
  end

end


