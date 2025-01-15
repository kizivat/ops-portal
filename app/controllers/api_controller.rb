class ApiController < ActionController::API
  before_action :default_format_json

  private

  def authenticate_client
    # TODO
    @client = Client.first
  end

  def default_format_json
    request.format = "json"
  end
end
