OmniAuth.config.full_host = Rails.env.production? ? "https://本番URL" : "http://localhost:3000"
OmniAuth.config.allowed_request_methods = %i[post get]
OmniAuth.config.silence_get_warning = true
OmniAuth.config.request_validation_phase = nil
