module SearchEngine
  require_relative 'search_engine/search'
  require_relative 'search_engine/configuration'

  # Ensure that the included model name is used in the search query
  # All configuration is defined in SearchEngine::Search.configuration
  # Model name is contained in SearchEngine::Search.model_name
  def self.included(model_class)
    SearchEngine::Search.model_name = model_class
  end
end