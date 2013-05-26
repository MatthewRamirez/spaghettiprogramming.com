FactoryGirl.define do

  factory :blog_attachment do |f|
    f.blog_post_id 1
    f.file_file_name "#{Rails.root}/public/404.html"
    f.file_content_type 'text/html'
    f.file_file_size 2048
    f.file_updated_at Time.now
  end

end
