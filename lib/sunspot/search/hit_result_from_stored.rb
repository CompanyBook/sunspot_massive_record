module Sunspot
  module Search
    class AbstractSearch
      #
      # Returns result objects populated from attributes stored in solr.
      #
      # This makes it easy to use records in view just like they came from
      # the database, except they came from whatever was stored inside of solr.
      #
      # Typically you can use this when you present your search results page or
      # something and you don't want to hit the database.
      #
      def results_from_stored_attributes
        hits.collect do |hit|
          record = hit.class_name.constantize.allocate.tap do |record|
            record.init_with('attributes' => stored_attributes_from_hit(hit))
            record.readonly!
          end

          hit.result_from_stored_attributes = record
        end
      end


      private


      #
      # Returns hash with attributes to be used to build a MassiveRecord ORM
      # object with.
      #
      def stored_attributes_from_hit(hit) # :nodoc:
        Hash[hit.class_name.constantize.known_attribute_names.collect do |attribute_name|
          stored_value = hit.stored(attribute_name)
          stored_value = stored_value.first if stored_value.is_a? Array

          [attribute_name, stored_value]
        end].tap do |attributes|
          attributes['id'] = hit.primary_key
        end
      end
    end






    class Hit
      attr_writer :result_from_stored_attributes

      #
      # Returns the result from the hit populated with attributes
      # from stored values.
      #
      def result_from_stored_attributes
        return @result_from_stored_attributes if @result_from_stored_attributes
        @search.results_from_stored_attributes
        @result_from_stored_attributes
      end
      alias_method :instance_from_stored_attributes, :result_from_stored_attributes
    end
  end
end
