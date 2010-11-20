# A client which can be used to retrieve some information about what a user
# and his friends "like" on Facebook.
class FacebookClient
  # Requires a Facebook Application client_id and secret_id. The token is
  # optional; it can be found by calling authorize and check_authorization.
  def initialize(key, secret, token = nil)
    @client = FBGraph::Client.new :client_id => key, :secret_id => secret, 
      :token => token
  end
  
  # When called, it will prompt a Facebook authorization page to the user. If
  # it succeeds, it will redirect the user to callback_url.
  def authorize callback_url
    @client.authorization.authorize_url :redirect_uri => callback_url,
      :scope => 'user_photos,friends_photos,user_likes,friends_likes'
  end
  
  # Once the user has called authorize and gone through the authorization
  # process, this method will return an access token for the current user.
  def check_authorization code, callback_url
    @client.authorization.process_callback(code, callback_url)
  end
  
  # Retrieves an array of hashes representing each of the user's friends,
  # with links to their profile pictures.
  def friends_with_pictures
    @client.selection.me.friends.info!["data"].each do |friend|
      friend["picture"] = @client.selection.user(friend[:id]).picture
    end
  end
  
  # Given a friend's user id, retrieve their name.
  def friend_name friend
    friend_info = @client.selection.user(friend).info!
    
    "#{friend_info['first_name']} #{friend_info['last_name']}"
  end
  
  # Given a friend's user id, retrieve the things which you both "like".
  def friend_and_you_both_like friend
    friend_likes = @client.selection.user(friend).likes.info!["data"]
    user_likes = @client.selection.me.likes.info!["data"]
    
    user_likes.find_all do |user_like|
  		friend_likes.find do |friend_like|
  			user_like["name"] == friend_like["name"]
  		end
  	end
  end
end