require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/../stubs/friends_controller_stub"
require "#{File.dirname(__FILE__)}/../stubs/facebook_client_stub"
require 'rails/performance_test_help'

# Profiling results for each test method are written to tmp/performance.
# These tests only profile rendering and not retrieval of data from Facebook.
class BrowsingTest < ActionDispatch::PerformanceTest
  def test_homepage
    get '/'
  end
  
  def test_list
    get '/friends/list'
  end
  
  def test_show
    get '/friends?friend=1923789'
  end
end
