require 'net/http'
require 'uri'

class RepoAudit::FileRequestHelper
  class << self
    def exists?(url)
      http(url).request_head(url).is_a?(Net::HTTPSuccess)
    end

    def fetch(url)
      http(url).get(url).body
    end

    private

    def http(url)
      uri = URI.parse(url)
      Net::HTTP.new(uri.host, uri.port).tap { |h| h.use_ssl = true }
    end
  end
end
