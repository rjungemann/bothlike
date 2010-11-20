# This is a stub version of FacebookClient. I ran the client once and
# retrieved correct data it returned as a series of YAML files. I then
# randomized the YAML data with the Faker gem. Now, FacebookClient can be
# tested to see if the methods are called in the right order, whether it will
# return generated data.
#
# In the future, it would probably be useful to use either the capybara or
# webrat gems to automate the authorization process.
class FacebookClient
  def initialize(key, secret, token = nil); end
  def authorize callback_url; end
  def check_authorization code, callback_url; end

  def friends_with_pictures
    YAML::load(open("#{File.dirname(__FILE__)}/data/friends_with_pictures.yml"))
  end

  def friend_name friend
    YAML::load(open("#{File.dirname(__FILE__)}/data/friend_name.yml"))
  end

  def friend_and_you_both_like friend
    YAML::load(open("#{File.dirname(__FILE__)}/data/likes.yml"))
  end
end