module SearchEngine
  class Engine
    def initialize(filters:)
      @filters = filters
    end

    def search(scope, params)
      @filters.each do |filter|
        scope = filter.apply(scope, params)
      end

      build_results(scope, params)
    end

    private

    def build_results(scope, params)
      results = Results.new
      permitted_params = @filters.each_with_object([]) do |filter, p|
        filter.add_permitted_params(p)
      end
      results.search_params = params.permit(*permitted_params)
      results.hits = scope
      @filters.each do |filter|
        filter.add_applied_filter(results)
      end

      @filters.each do |filter|
        filter.add_visible_filter(results)
      end

      results
    end
  end
end
