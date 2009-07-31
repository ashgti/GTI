require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe User do
  before :each do
    User.all.destroy!
    Page.all.destroy!
  end
  
  describe "Validations" do
    describe '#password' do 
      it "should require a password for new users" do
        user = User.new
        user.email = 'testing@example.com'
        user.login = 'testing'
        
        user.valid?.should be_false
        user.errors.on(:password).should == ["Password must not be blank"]
      end
    end
  end
  
  describe "Hooks" do
    describe "#password" do      
      it "should encrypt the password" do
      end
    end
  end
end
