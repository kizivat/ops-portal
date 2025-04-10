require "test_helper"

class Issues::Drafts::SummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get issues_drafts_summary_show_url
    assert_response :success
  end
end
