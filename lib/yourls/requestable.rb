module Yourls
  module Requestable
    require 'rest_client'

    def already_shortened?
      regex = Regexp.new(domain)
      @url =~ regex
    end

    def base_params
      {
        format:       'json',
        timeout:      20,
        open_timeout: 20
      }.merge(authentication)
    end

    def authentication
      if config.api_key.present?
        { signature: config.api_key }
      else
        {
          username: config.username,
          password: config.password
        }
      end
    end

    def timeout_hash
      { timeout: config.timeout } if config.timeout
    end

    def timeout_hash
      { open_timeout: config.open_timeout } if config.open_timeout
    end

    def format
      { format: 'json' }
    end

    def api_key
      config.api_key
    end

    def host
      config.api_endpoint || config.host
    end

    def domain
      config.domain
    end

    def config
      Yourls::Configuration
    end
  end
end
