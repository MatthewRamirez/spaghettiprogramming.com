FactoryGirl.define do
  blog_attachments = [ Rack::Test::UploadedFile.new("#{Rails.root}/public/404.html") ]

  factory :blog_post do |f|
    f.title "Test tile"
    f.body "Test body"
    f.slug "Test slug"
    f.published true
    f.blog_attachments_array blog_attachments
  end

  factory :invalid_blog_post, parent: :blog_post do |f|
    f.title nil
  end

  factory :unpublished_blog_post, parent: :blog_post do |f|
    f.published false
  end
end
