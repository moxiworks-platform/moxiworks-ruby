$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'moxiworks_platform'
require 'vcr'


VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = false
  #c.debug_logger = File.open('/tmp/foi', 'w')
end

def symbolize_keys(hash)
  Hash[hash.map { |k, v| [k.to_sym, v] }]
end
