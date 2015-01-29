module Yourls
  module Requestable
    require 'rest_client'

    private

    def already_shortened?
      regex = Regexp.new(domain)
      @url =~ regex
    end

    def base_params
      {
        signature:    api_key,
        format:       'json',
        timeout:      20,
        open_timeout: 20
      }
    end

    def api_key
      YOURLS_CONFIG['api_key']
    end

    def host
      YOURLS_CONFIG['host']
    end

    def domain
      URI.parse(host).host
    end
  end
end
