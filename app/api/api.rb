# aggregator class which aggregates the API endpoints
class API < Grape::API
  prefix "api"
  format :json

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status: e.status,
      error_msg: e.message
    }.to_json, 400)
  end

  rescue_from :all do |e|
    Rails.logger.error("API Error: #{e.class} - #{e.message}\n#{e.backtrace&.first(5)&.join("\n")}")
    if Rails.env.development?
      error_response(message: e.message, status: 500)
    else
      error_response(message: "Internal server error", status: 500)
    end
  end
  
  mount API::V1::Base



  add_swagger_documentation format: :json,
                            hide_documentation_path: false,
                            array_use_braces: true,
                            info: {
                              title: "API",
                              Description: "API"
                            }
  get :status do
    { status: "API is running" }
  end
end
