module Sunspot
  module Rails
    class StubSessionProxy
      class Search
        # Just adding support for extra functionality call which this lib provides
        def results_from_stored_attributes
          []
        end
      end
    end
  end
end

