# Contains methods that a controller can use internally to:
# * Get a user authenticated on Facebook
# * Display information about a user and his or her friends
module FacebookModule
  protected

  # The url that the user will return to after being authorized.
  # Override in each respective controller (for example, FriendsController)
  def oauth_callback_url
  end
  
  # Returns nil if the user isn't authorized. Otherwise, returns the user's
  # unique access token.
  def oauth_access_token
    session[:access_token]
  end

  # Get a FacebookClient instance, from which you can find more information
  # about the current user.
  def facebook_client
    FacebookClient.new FB_CONFIG[:client_id], FB_CONFIG[:secret_id],
      session[:access_token]
  end
  
  # Sends the user to a Facebook authentication or authorization page, so we
  # can get permission to access their account. They'll be redirected to
  # oauth_callback_url.
  def oauth_authorize
    redirect_to facebook_client.authorize(oauth_callback_url)
  end
  
  # Retrives the user's info once they've been authorized.
  def oauth_check_authorization
    code = params[:code]
    session[:access_token] = facebook_client.check_authorization code,
        :redirect_uri => oauth_callback_url
  end
end