FactoryGirl.define do
  factory :blog_post do |f|
    f.title "Test tile"
    f.body "Test body"
    f.slug "Test slug"
    f.published true
  end

  factory :invalid_blog_post, parent: :blog_post do |f|
    f.title nil
  end

  factory :unpublished_blog_post, parent: :blog_post do |f|
    f.published false
  end
end
