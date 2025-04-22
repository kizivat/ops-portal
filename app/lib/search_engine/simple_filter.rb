module SearchEngine
  class SimpleFilter
    def initialize(
      param_name,
      label: -> { _1.join(", ") },
      filter:,
      visible_filter_label: nil,
      items_finder: nil
    )
      @param_name = param_name
      @label = label
      @filter = filter
      @items_finder = items_finder
      @visible_filter_label = visible_filter_label
    end

    def apply(scope, params)
      return scope unless params[@param_name].present?
      @filter.call(scope, params)
    end

    def add_permitted_params(permitted_params)
      permitted_params << @param_name
      permitted_params << { @param_name => [] } # allow arrays too
    end

    def add_applied_filter(results)
      return unless results.search_params[@param_name].present?

      values = Array(results.search_params[@param_name])

      filter_result = SimpleResultsFilter.new(
        name: @name,
        label: @label.respond_to?(:call) ? @label.call(values) : @label,
        remove_filter_params: results.search_params.except(@param_name),
      )
      results.applied_filters << filter_result
    end

    def build_items(results, items)
      values = Array(results.search_params[@param_name])

      items.map do |value|
        VisibleFilterResult::Item.new(
          label: value,
          value: value,
          selected: values.include?(value),
          add_params: results.search_params.merge(@param_name => (values + [ value ]).uniq),
          remove_params: results.search_params.merge(@param_name => (values - [ value ]).uniq),
        )
      end.sort_by { |i| i.selected? ? [ -1, i.label ] : [ 1, i.label ] }
    end

    def add_visible_filter(results)
      return unless @items_finder

      result = VisibleFilterResult.new(
        name: @name,
        label: @visible_filter_label,
        items: build_items(results, @items_finder.respond_to?(:call) ? @items_finder.call : @items_finder),
      )
      results.visible_filters << result
    end
  end
end
