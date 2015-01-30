file = Rails.root.join(*%w(config yourls.yml))
if File.exist?(file)
  YOURLS_CONFIG = YAML.load_file(file).symbolize_keys
end
