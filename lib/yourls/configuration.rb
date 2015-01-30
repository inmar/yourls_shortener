module Yourls
  module Configuration
    extend self

    # TODO: (dysnomian) Add a method to crunch these into a params hash
    #   intelligently as they are present.

    def to_params
      [].tap do |fields|
        YOURLS_CONFIG.each do |name, contents|
          fields[translate(name.to_sym)] = contents
        end
      end
    end

    def translate(name)
      dictionary = {
        api_key: :signature
      }
      dictionary.fetch(name, name)
    end

    def field(field, params_key)
      YOURLS_CONFIG.fetch(key, nil)
    end

    def api_key
      YOURLS_CONFIG.fetch(:api_key)
    end

    def api_endpoint
      YOURLS_CONFIG.fetch(:api_endpoint, Yourls::NotConfiguredError)
    end

    def domain
      YOURLS_CONFIG.fetch(:domain, domain_from_endpoint)
    end

    def username
      YOURLS_CONFIG.fetch(:username, nil)
    end

    def password
      YOURLS_CONFIG.fetch(:username, nil)
    end

    def timeout
      YOURLS_CONFIG.fetch(:timeout, nil)
    end

    def open_timeout
      YOURLS_CONFIG.fetch(:open_timeout, nil)
    end

    # NOTE: (dysnomian) It's JSON. If you want something else, implement it
    #  yourself.
    def format
      'json'
    end

    private

    def domain_from_endpoint
      return Yourls::NotConfiguredError unless api_endpoint
      URI.parse(api_endpoint).host
    end
  end
end
