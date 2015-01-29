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
