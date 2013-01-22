Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_CONFIG["GOOGLE_KEY"], APP_CONFIG["GOOGLE_SECRET"], {access_type: 'online', approval_prompt: ''}
end

