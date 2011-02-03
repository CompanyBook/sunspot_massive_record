require 'spec_helper'

describe Sunspot::Search::AbstractSearch do
  include MassiveRecord::Rspec::SimpleDatabaseCleaner

  before do
    @person = PersonSearchable.create! :name => "test name", :free_text => "free text", :age => 29, :not_stored => "should be empty from stored"
    PersonSearchable.solr_index :batch_size => nil
    
    @search = PersonSearchable.search { |s| s.keywords(@person.free_text) }
  end

  after do
    Sunspot.remove_all PersonSearchable
  end

  it "should be indexed" do
    @search.results.first.should == @person
  end


  describe "#results_attributes_from_index" do
    before do
      @person_from_stored_attributes = @search.results_from_stored_attributes.first
      @person_from_stored_attributes
    end

    it "should not hit the database" do
      PersonSearchable.should_not_receive :find
      @search.results_from_stored_attributes
    end

    it "should be considered equal to what is in the database" do
      @person_from_stored_attributes.should == @person
    end

    it "should return read only results" do
      @person_from_stored_attributes.should be_readonly
    end
  end
end
