require 'spec_helper'

describe MassiveRecord::ORM::Base do
  it "should include the module which gives it searchable ability" do
    MassiveRecord::ORM::Base.included_modules.should include(Sunspot::MassiveRecord)
  end
end
