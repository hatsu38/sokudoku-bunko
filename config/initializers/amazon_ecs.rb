Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = Rails.application.credentials.aws[:access_key_id]
  options[:AWS_secret_key] = Rails.application.credentials.aws[:secret_access_key]
  options[:associate_tag] = Rails.application.credentials[:associate_tag]
end
