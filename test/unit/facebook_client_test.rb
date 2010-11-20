require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/../stubs/friends_controller_stub"
require "#{File.dirname(__FILE__)}/../stubs/facebook_client_stub"

class FacebookClientTest < ActiveSupport::TestCase
  # Setup a stubbed FacebookClient. That way we can at least test if the
  # methods can be called in the expected order, without worrying about going
  # through the manual authorization process, which requires the user visiting
  # a web page and clicking a button.
  def setup
    @client = FacebookClient.new("some_client_id", "some_secret_key")
    
    @client.authorize "some_callback_url"
    @client.check_authorization "some_param_code", "some_callback_url"
  end
  
  test "should be able to retrieve a list of users" do
    friends = @client.friends_with_pictures
    
    assert_equal friends.size, 438
    
    friends_missing_attributes = friends.find_all do |friend|
      friend["name"].nil? || friend["id"].nil? || friend["picture"].nil?
    end
    
    assert_equal friends_missing_attributes.size, 0
  end
  
  test "should be able to retrieve a friend's name from an id" do
    id = "1923789"
    name = @client.friend_name id
    
    assert_equal name, "Estel Parker"
  end
  
  test "should be able to see what a user and a friend both like" do
    id = "1923789"
    name = "Estel Parker"
    likes = @client.friend_and_you_both_like id
    
    assert_equal likes.size, 10
    
    likes_missing_attributes = likes.find_all do |like|
      like["name"].nil? || like["category"].nil? || like["id"].nil? ||
        like["created_time"].nil?
    end
    
    assert_equal likes_missing_attributes.size, 0
  end
end
