module SearchEngine
  class SimpleResultsFilter
    attr_reader :name, :label, :remove_filter_params, :items

    def initialize(name:, label:, remove_filter_params:)
      @name = name
      @label = label
      @remove_filter_params = remove_filter_params
    end

    def to_partial_path
      "search_engine/simple_results_filter"
    end
  end
end
