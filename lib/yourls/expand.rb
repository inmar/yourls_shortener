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
