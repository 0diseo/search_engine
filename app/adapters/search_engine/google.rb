module Search
  class GoogleSearchEngine
    def search(text)
      result = GoogleCustomSearchApi.search(text)
      parse_results(result)
    end

    private
    def parse_results(results)
      results.items.map do |item|
        {
          title: item.title,
          link: item.link,
          snippet: item.snippet
        }
      end
    end
  end
end

