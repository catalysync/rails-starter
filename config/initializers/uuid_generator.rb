Rails.application.config.generators do |generate|
  generate.orm :active_record, primary_key_type: :uuid
end
