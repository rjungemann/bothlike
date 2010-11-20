# Since the "signin" action requires a redirect to a Facebook authorization
# page which requires manual user input, I stubbed the class to short-circuit
# the authorization process and immediately redirect the user to the eventual
# action ("list"), so that the application flow can be tested in an automatic
# manner.
class FriendsController < ApplicationController
  def signin
    redirect_to :action => "list"
  end
  
  def list
    @friends = facebook_client.friends_with_pictures
  end
end