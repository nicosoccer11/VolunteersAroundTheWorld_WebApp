Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['793309384892-e95dg1c44vl3tt9mvdorr7drtfejoemm.apps.googleusercontent.com'], ENV['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']
end
  