# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == 'test'
  User.destroy_all
  user = FactoryGirl.create(:user)
  user.save!
  user = FactoryGirl.create(:user_with_password_digest)
  user.save!
end
