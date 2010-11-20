require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/../stubs/friends_controller_stub"
require "#{File.dirname(__FILE__)}/../stubs/facebook_client_stub"

class FriendsControllerTest < ActionController::TestCase
  test "index" do
    get :start
    assert_response :success
  end
  
  test "signin" do
    get :signin
    assert_response :redirect
    assert_redirected_to :action => "list"
  end
  
  test "list" do
    get :list
    assert_response :success
  end
  
  test "show" do
    get :show, :friend => "1923789"
    assert_response :success
  end
end
