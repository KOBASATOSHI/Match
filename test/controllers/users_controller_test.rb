require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:User1)
  end
  
  test "should get new" do
    get signup_url
    assert_response :success
  end
  
  test "should redirect to login_url when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
