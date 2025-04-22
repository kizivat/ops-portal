module SearchEngine
  class Results
    attr_accessor :hits, :applied_filters, :visible_filters, :search_params

    def initialize
      @hits = []
      @applied_filters = []
      @visible_filters = []
      @search_params = {}
    end
  end
end
