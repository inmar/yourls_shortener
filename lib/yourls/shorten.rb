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
