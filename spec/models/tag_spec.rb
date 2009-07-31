require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Tag do
  describe "Validations" do
    describe "#name" do
      it "should be required" do
        tag = Tag.new
        pending("tags need work")
        tag.should_not be_valid
      end
    end
  end
end