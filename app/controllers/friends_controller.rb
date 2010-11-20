# This controller allows a user to:
# * Sign into Facebook
# * Retrieve a list of friends
# * Pick a friend
# * Display what the user and the picked friend both "like" on Facebook
class FriendsController < ApplicationController
  include FacebookModule
  
  def start
  end
  
  # See if the application has permission to retrieve user's info. If it does,
  # redirect to oauth_callback_url, which is the "show" action in this case.
  def signin
    oauth_authorize
  end
  
  # Lists a user's friends. After a user visits the "signin" action, they get
  # redirected here. In order to capture their session info,
  # oauth_check_authorization must be called in this method.
  def list
    oauth_check_authorization
    
    @friends = facebook_client.friends_with_pictures
  end
  
  # Show what the user and one of their friends both "like" on Facebook.
  def show
    @friend_name = facebook_client.friend_name params[:friend]
    @likes = facebook_client.friend_and_you_both_like params[:friend]
  end
  
  protected
  
  # The url the user is redirected to once they've called oauth_authorize in
  # the signin action.
  def oauth_callback_url
    url_for :action => "list"
  end
end
