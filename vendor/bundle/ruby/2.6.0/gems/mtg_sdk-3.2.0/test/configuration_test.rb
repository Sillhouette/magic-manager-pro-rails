#test/client_test.rb
require_relative 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_defaults
    config = MTG::Configuration.new

    assert_equal 1, config.api_version
  end
  
  def test_reset
    MTG.configure do |config|
      config.api_version = 2
    end
    
    MTG.reset
    
    assert_equal 1, MTG.configuration.api_version
  end
end