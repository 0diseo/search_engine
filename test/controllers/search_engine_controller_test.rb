require 'test_helper'

class SearchEngineControllerTest < ActionController::TestCase

  test 'should get google search' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index,  search_engines: 'google', text: 'odiseo'
    assert response.body == google_search.to_json
    assert_response :success
  end

  test 'should get bing search' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index,  search_engines: 'bing', text: 'odiseo'
    assert response.body == bing_search.to_json
    assert_response :success
  end

  test 'should get google and bing serch' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index, search_engines: %w[google bing], text: 'odiseo'
    puts response.inspect
    assert response.body == bing_and_google_search.to_json
    assert_response :success
  end

  test 'should get empty when search_engines is nil' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index, search_engines: nil, text: 'odiseo'
    assert response.body == '{}'
    assert_response :success
  end

  test 'should get empty when search_engines is empty' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index, search_engines: '', text: 'odiseo'
    assert response.body == '{}'
    assert_response :success
  end

  test 'should get empty when search_engines is no valid' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index, search_engines: 'no valid', text: 'odiseo'
    assert response.body == '{}'
    assert_response :success
  end

  test 'should get google and bing serch adding not valid search_engines' do
    Search.google_engine = GoogleSearchDummy
    Search.bing_engine = BingSearchDummy
    get :index, search_engines: ['google', 'bing', nil, ''], text: 'odiseo'
    assert response.body == bing_and_google_search.to_json
    assert_response :success
  end

  private

  def google_search
    { 'google' => GoogleSearchDummy.search(0) }
  end

  def bing_search
    { 'bing' => BingSearchDummy.search(0) }
  end

  def bing_and_google_search
    google_search.merge(bing_search)
  end

  class GoogleSearchDummy
    def self.search(text)
      [
        { title: 1, link: 'a', snippet: 'z'},
        { title: 2, link: 'b', snippet: 'x'},
        { title: 3, link: 'c', snippet: 'y'}
      ]
    end
  end

  class BingSearchDummy
    def self.search(text)
      [
        { title: 9, link: 'A', snippet: 'Z'},
        { title: 8, link: 'B', snippet: 'X'},
      ]
    end
  end

end
