require "test_helper"

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get ticket-updated" do
    post webhooks_updated_url
    assert_response :success
  end
end
