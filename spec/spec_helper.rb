require 'chefspec'
require 'chefspec/berkshelf'
require 'pry'

RSpec.configure do |config|
  config.cookbook_path = '../test/cookbooks'
end
