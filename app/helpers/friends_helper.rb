# Helper methods to simplify the displaying of Facebook friends.
module FriendsHelper
  # Given a string of content and a friend_id, generate a link to a friend.
  def link_to_friend content, friend_id
    link_to content, :action => 'show', :friend => friend_id
  end
end
