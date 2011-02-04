require 'spec_helper'

describe "results from stored attributes" do
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





  describe Sunspot::Search::AbstractSearch do
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

      it "should insert created object in hit" do
        @search.hits.first.result_from_stored_attributes.should == @person_from_stored_attributes
      end

      %w(name free_text age).each do |attr_name|
        it "should have #{attr_name} equal to object in database" do
          @person_from_stored_attributes.send(attr_name).should == @person.send(attr_name)
        end
      end
    end
  end



  describe Sunspot::Search::Hit do
    describe "#result_from_stored_attributes" do
      before do
        @hit = @search.hits.first
      end

      it "should not hit the database" do
        PersonSearchable.should_not_receive :find
        @hit.result_from_stored_attributes
      end

      it "should ask the search for results_attributes_from_index" do
        @search.should_receive(:results_from_stored_attributes)
        @hit.result_from_stored_attributes
      end

      it "should only ask search for results_from_stored_attributes once" do
        hits = @search.hits
        @search.should_receive(:hits).once.and_return(hits)
        2.times { @hit.result_from_stored_attributes }
      end

      it "should be considered equal to what is in the database" do
        @hit.result_from_stored_attributes.should == @person
      end

      it "should return read only results" do
        @hit.result_from_stored_attributes.should be_readonly
      end

      %w(name free_text age).each do |attr_name|
        it "should have #{attr_name} equal to object in database" do
          @hit.result_from_stored_attributes.send(attr_name).should == @person.send(attr_name)
        end
      end
    end
  end
end

