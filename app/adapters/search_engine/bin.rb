
module Search
  class BingSearchEngine
    def initialize
      @accessKey = "fdd62c3da99246b49b7d399987d98bfe"
      @uri_engine  = "https://api.cognitive.microsoft.com"
      @path = "/bing/v7.0/search"
    end

    def search(text)
      uri = create_endpoint_uri(text)
      request = create_request(uri)
      result = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end
      filter_result = get_results(result)
      parse_results(filter_result)
    end

    private

    attr_reader :accessKey, :uri_engine, :path

    def create_request(uri)
      request = Net::HTTP::Get.new(uri)
      request['Ocp-Apim-Subscription-Key'] = accessKey
      request
    end

    def create_endpoint_uri(text)
      URI(uri_engine + path + "?q=" + URI.escape(text))
    end

    def get_results(result)
      parse_result = JSON.parse(result.body)
      parse_result["webPages"]["value"]
    end

    def parse_results(results)
      results.map do |item|
        {
          title: item["name"],
          link: item["url"],
          snippet: item["snippet"]
        }
      end
    end
  end
end
