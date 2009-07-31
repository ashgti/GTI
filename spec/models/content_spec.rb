require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Content do
  describe "#process" do
    it 'should raise an error if called on generic content' do 
      content = Content.new
      lambda { content.process(nil, nil) }.should raise_error ImplementationError
    end
  end
end