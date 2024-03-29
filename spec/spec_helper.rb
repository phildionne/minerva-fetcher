require 'coveralls'
Coveralls.wear!

require 'dotenv'
Dotenv.load

require 'bundler/setup'
require 'rspec'
require 'vcr'

require 'minerva_fetcher'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].map(&method(:require))

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.filter_run_excluding skip: true
  config.run_all_when_everything_filtered = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/cassettes'
  c.hook_into :faraday
  c.configure_rspec_metadata!
end
