class SearchEngineController < ApplicationController
  def index
    result = Search.search(search_engines, text)
    render json: result.to_json
  end

  private

  def search_engines
    params['search_engines']
  end

  def text
    params['text']
  end
end
