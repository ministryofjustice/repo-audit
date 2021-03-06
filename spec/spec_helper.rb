require 'rspec'
require 'checks/checks_shared_examples'
require_relative '../lib/repo-audit'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

