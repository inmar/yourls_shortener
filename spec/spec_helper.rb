require 'pry'
require 'rspec'
require 'vcr'
require 'yaml'
require 'hash_symbolizer'

ROOT = Pathname(File.expand_path(File.join(File.dirname(__FILE__), '..')))

$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'yourls')

require File.join(ROOT, 'lib', 'yourls_shortener.rb')

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
end

file = ROOT.join(*%w(spec fixtures yourls.yml))

if File.exist?(file)
  YOURLS_CONFIG = YAML.load_file(file).symbolize_keys
end
