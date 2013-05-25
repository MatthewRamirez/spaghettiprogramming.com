FactoryGirl.define do
  valid_oauth_hash = {
      'extra'=>{
        'raw_info'=>{
          'id'=>'123456',
          'name'=>'test_name',
          'email'=>'test_admin@example.com',
          'link'=>'http://www.google.com',
          'provider'=>'google' }}}
  invalid_oauth_hash = {
      'extra'=>{
        'raw_info'=>{
          'id'=>'123456',
          'name'=>'test_name',
          'email'=>'invalid@example.com',
          'link'=>'http://www.google.com',
          'provider'=>'google' }}}

  factory :user do |f|
    f.email_address "test@email.com"
  end

  factory :user_valid_oauth_params, parent: :user do |f|
    f.oauth_params valid_oauth_hash
  end

  factory :user_invalid_oauth_params, parent: :user do |f|
    f.oauth_params invalid_oauth_hash
  end
end
