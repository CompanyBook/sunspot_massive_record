module Sunspot
  module Search
    class AbstractSearch
      def results_from_stored_attributes
        hits.collect do |hit|
          hit.class_name.constantize.allocate.tap do |record|
            record.init_with('attributes' => stored_attributes_from_hit(hit))
            record.readonly!
          end
        end
      end


      private



      def stored_attributes_from_hit(hit)
        Hash[hit.class_name.constantize.known_attribute_names.collect do |attribute_name|
          stored_value = hit.stored(attribute_name)

          [attribute_name, stored_value]
        end].tap do |attributes|
          attributes['id'] = hit.primary_key
        end
      end
    end

    class Hit
    end
  end
end
