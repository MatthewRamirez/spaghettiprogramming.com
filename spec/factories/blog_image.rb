FactoryGirl.define do

  factory :blog_image do |f|
    f.blog_post_id 1
    f.image_file_name "#{Rails.root}/public/images/spaghetti1.jpg"
    f.image_content_type 'image/jpg'
    f.image_file_size 20480
    f.image_updated_at Time.now
  end

end
