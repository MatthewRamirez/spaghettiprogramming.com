FactoryGirl.define do

  factory :user do |f|
    f.email "user@email.com"
    f.nick "nick"
    f.identifier_url "www.google.com"
    f.password "12345"
    f.password_confirmation "12345"
  end

  factory :user_with_changed_email, parent: :user do |f|
    f.email "user_with_changed_email@email.com"
  end

  factory :user_with_invalid_login, parent: :user do |f|
    f.email "user_with_invalid_login@email.com"
    f.password "1"
    f.password_confirmation "1"
    f.password_digest "digest"
  end

  factory :user_with_password_digest, parent: :user do |f|
    f.email "user_with_password_digest@email.com"
    f.password_digest "digest"
  end

end
