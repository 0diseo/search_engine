require_relative '../../app/services/search'
require_relative '../../app/adapters/search_engine/google'
require_relative '../../app/adapters/search_engine/bin'


module Search
  RSpec.describe 'search engines' do
    def google_search
      [
        { title: 1, link: 'a', snippet: 'z'},
        { title: 2, link: 'b', snippet: 'x'},
        { title: 3, link: 'c', snippet: 'y'}
      ]
    end

    def bing_search
      [
        { title: 9, link: 'A', snippet: 'Z'},
        { title: 8, link: 'B', snippet: 'X'},
      ]
    end

    before do
      google_search_dummy = instance_double(GoogleSearchEngine)
      bing_search_dummy = instance_double(BingSearchEngine)
      Search.google_engine = google_search_dummy
      Search.bing_engine = bing_search_dummy
      allow(google_search_dummy).to receive(:search).with('odiseo').and_return(google_search)
      allow(bing_search_dummy).to receive(:search).with('odiseo').and_return(bing_search)
    end

    it 'return google search' do
      result = Search.search('google', 'odiseo')
      expect(result).to eq({ 'google' => google_search })
    end

    it 'return bing search' do
      result = Search.search('bing', 'odiseo')
      expect(result).to eq({ 'bing' => bing_search })
    end

    it 'return google and bing search' do
      result = Search.search(%w[bing google], 'odiseo')
      expect(result).to eq({ 'bing' => bing_search, 'google' => google_search })
    end

    it 'return empty when search_engine nil' do
      result = Search.search(nil, 'odiseo')
      expect(result).to eq({})
    end

    it 'return empty when search_engine empty' do
      result = Search.search('', 'odiseo')
      expect(result).to eq({})
    end

    it 'return empty when search_engine is not valid' do
      result = Search.search('no valid', 'odiseo')
      expect(result).to eq({})
    end

    it 'return google and bing search adding not valid search engines' do
      result = Search.search(['bing', 'google', nil, '', 'no valid'], 'odiseo')
      expect(result).to eq({ 'bing' => bing_search, 'google' => google_search })
    end
  end
end
