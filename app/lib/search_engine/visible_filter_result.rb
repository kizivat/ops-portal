module SearchEngine
  class VisibleFilterResult
    attr_reader :name, :label, :items

    class Item
      attr_reader :label, :add_params, :remove_params

      def initialize(label:, value:, add_params:, remove_params:, selected:)
        @label = label
        @value = value
        @add_params = add_params
        @remove_params = remove_params
        @selected = selected
      end

      def selected?
        @selected
      end
    end

    def initialize(name:, label:, items:)
      @name = name
      @label = label
      @items = items
    end

    def to_partial_path
      "search_engine/visible_filter_result"
    end
  end
end
