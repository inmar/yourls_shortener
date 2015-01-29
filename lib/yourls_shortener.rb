module Yourls
  module Requestable
    require 'rest_client'

    private

    def already_shortened?
      @url =~ /cbi.as/
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
  end
end

module Yourls
  module Clicks
    include Requestable
    extend self

    def url(url)
      @url = url

      clicks_from(url_stats_request)
    end

    private

    def url_stats_request
      RestClient.get(host, params: url_stats_params)
    end

    def url_stats_params
      base_params.merge({
        action:       'url-stats',
        shorturl:     @url
      })
    end

    def clicks_from(results)
      link_hash_from(results).fetch('clicks', '').to_i
    end

    def link_hash_from(results)
      JSON.parse(results).fetch('link')
    end
  end
end

module Yourls
  module Shorten
    include Requestable
    extend self

    def url(url)
      @url = url
      return url if already_shortened?

      shorturl_from(shorturl_request)
    end

    def shorturl_request
      RestClient.get(host, params: shorturl_params)
    end

    def shorturl_params
      base_params.merge({
        url:          @url,
        action:       'shorturl',
        format:       'json'
      })
    end

    def shorturl_from(results)
      JSON.parse(results).fetch('shorturl')
    end
  end
end

module Yourls
  module Expand
    include Requestable
    extend self

    def url(url)
      @url = url

      return url unless already_shortened?
      longurl_from(expand_request)
    end

    private

    def expand_request
      RestClient.get(host, params: expand_params)
    end

    def expand_params
      base_params.merge({
        action:       'expand',
        shorturl:     @url
      })
    end

    def longurl_from(results)
      JSON.parse(results).fetch('longurl')
    end
  end
end

