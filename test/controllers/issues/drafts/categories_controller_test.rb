require "test_helper"

class Issues::Drafts::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get issues_drafts_categories_show_url
    assert_response :success
  end
end
