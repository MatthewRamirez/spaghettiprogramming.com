FactoryGirl.define do
  factory :blog_post do |f|
    f.title "Test tile"
    f.body "Test body"
    f.slug "Test slug"
    f.published true
  end
end
