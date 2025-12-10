Devise.setup do |config|
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  # Range for password length.
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  
  config.sign_out_via = :delete

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  # Параметры для защиты от brute force атак
  config.maximum_attempts = 5
  config.unlock_strategy = :time
  config.unlock_in = 30.minutes

  # config.reset_password_within = 6.hours
  config.reset_password_within = 6.hours

  # Отправка писем асинхронно
  config.mailer_sender = 'admin@example.com'
  # config.send_email_changed_notification = true
  # config.send_password_change_notification = true

  # Используем secure cookies в production
  config.rememberable_options = { secure: Rails.env.production? }
end
