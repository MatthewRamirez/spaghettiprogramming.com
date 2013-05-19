FactoryGirl.define do
  factory :blog_post do |f|
    f.title "Test tile"
    f.body "Test body"
    f.slug "Test slug"
  end
  factory :private_blog_post do |f|
    f.title "Test tile"
    f.body "Test body"
    f.slug "Test slug"
    f.public false
  end

end
