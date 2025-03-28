require "test_helper"

class Api::V1::ResponsibleSubjectControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get search_api_v1_responsible_subjects_url
    assert_response :success
  end
end
