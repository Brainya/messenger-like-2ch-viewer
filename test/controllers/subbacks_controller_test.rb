require 'test_helper'

class SubbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subbacks_index_url
    assert_response :success
  end

end
