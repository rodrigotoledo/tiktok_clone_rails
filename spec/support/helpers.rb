# frozen_string_literal: true

require "shoulda/matchers"
require "rspec/json_expectations"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    PASSWORD_FOR_USER = "password123"
  end
end
