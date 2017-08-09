OmniAuth.config.logger = Rails.logger
    
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1459884527429653', '990f7e990c54c062b2684eda99a44991'
end