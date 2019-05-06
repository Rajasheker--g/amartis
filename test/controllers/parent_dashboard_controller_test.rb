require 'test_helper'

class ParentDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parent_dashboard_index_url
    assert_response :success
  end

end
