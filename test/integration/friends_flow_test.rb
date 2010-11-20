require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/../stubs/friends_controller_stub"
require "#{File.dirname(__FILE__)}/../stubs/facebook_client_stub"

class FriendsFlowTest < ActionDispatch::IntegrationTest
  test "user can pick a friend and sees what they both like" do
    # visit the start page first
    get "/"
    assert_response :success
    
    # follow the link to the page to pick a friend through the signin page
    get "/friends/signin"
    assert_response :redirect
    assert_redirected_to :action => "list"
    
    # follow a link for a friend to a page listing things they both like
    get "/friends/show", :friend => "1923789"
    assert_response :success
    
    # see if the user can "try again"
    get "/friends/signin"
    assert_response :redirect
    assert_redirected_to :action => "list"
  end
end
