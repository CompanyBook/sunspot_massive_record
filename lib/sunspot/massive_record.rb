module Sunspot
  module MassiveRecord
    extend ActiveSupport::Concern

    included do
      extend Sunspot::Rails::Searchable::ActsAsMethods
      Sunspot::Adapters::DataAccessor.register(DataAccessor, self)
      Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, self)
    end

    class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
      def id
        @instance.id
      end
    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
        @clazz.find(id) rescue nil
      end

      def load_all(ids)
        ids.collect do |id|
          @clazz.find(id)
        end
      end
    end
  end
end

MassiveRecord::ORM::Base.class_eval do
  include Sunspot::MassiveRecord
end
