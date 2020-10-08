require_relative '../adapters/search_engine/bin'
require_relative '../adapters/search_engine/google'

module Search
  def self.bing_engine=(engine)
    @bing_engine = engine
  end

  def self.bing_engine
    @bing_engine ||= BingSearchEngine.new
  end

  def self.google_engine=(engine)
    @google_engine = engine
  end

  def self.google_engine
    @google_engine ||= GoogleSearchEngine.new
  end

  def self.search(engines, search_text)
    engines = Array(engines)
    engines.map do |engine|
      { engine => search_engines[engine].search(search_text) } if search_engines.key?(engine) 
    end.compact.reduce(Hash.new, :merge)
  end

  private
  def self.search_engines
    {
      'google' => google_engine,
      'bing' => bing_engine
    }
  end
end
