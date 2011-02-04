# Sunspot adapter for MassiveRecord

This gem will give you the same searchable DSL as you have using sunspot rails and ActiveRecord.

## How to install

    gem install sunspot_massive_record

..or, if you are on Rails or anywhere else where you have a Gemfile:

    gem 'sunspot_massive_record'


## How to use

A good place to start is at http://github.com/outoftime/sunspot/wiki, as this gem is simply
an adapter which gives MassiveRecord the same ability as the sunspot-rails gives ActiveRecord.


### Quick example

If you really want a quick example, here is one:

    class PersonSearchable < MassiveRecord::ORM::Table
      column_family :info do
        field :name
        field :free_text
        field :age, :integer

        field :not_stored
      end


      searchable do
        string :name, :stored => true
        text :free_text, :stored => true
        integer :age
      end


      private

      def default_id
        next_id
      end
    end

This will make PersonSearchable class searchable bu name, free_text and age.

To do a search:
    
    # Define a search
    search = PersonSearchable.search { keywords("some search term") }

    # Retreive results
    search.hits     # Returns an array of hits
    search.results  # Returns an array of results (massive record records) read from the database


### Populate record from stored values

There is one thing we have added to the search object; the ability to populate
MassiveRecord object based on stored values in the search index. Notice how we
have defined name and free_text as stored - this will make it possible to do:

    # Populate result records only from values stored in the index, not hitting the database at all:
    search.results_from_stored_attributes

    # You can also do
    search.hits.first.result_from_stored_attributes # Returns the record for the first hit, populated by stored values
