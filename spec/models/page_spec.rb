require File.join(File.dirname(__FILE__), '..', "spec_helper")

describe Page do
  before :all do
    User.all.destroy! 
    @user = User.gen :admin
    Layout.all.destroy!
    @layout = Layout.gen
  end
  
  before :each do
    Page.all.destroy!
  end
  
  describe "Validations" do
    describe "#slug" do
      it "generate based off of the title" do
        page = Page.new
        page.title = 'Hello World'
        page.owner = @user
        page.layout = @layout

        page.valid?.should be true
        page.slug.should == page.title
      end
      
      it "should be unique" do
        Page.new(:title => 'Hello World', :owner => @user, :slug => 'hello-world', :layout => @layout).save

        page = Page.new
        page.title = 'Hello World'
        page.slug = 'hello-world'
        page.owner = @user
        page.layout = @layout

        page.valid?.should be_false
        page.errors.on(:slug).should_not be_nil
        page.errors.on(:slug).should_not be_empty
        page.errors[:slug].should == ['Slug is already taken']
      end
      
      it "should be overrideable" do
        page = Page.make(:title => 'Hello World', :owner => @user, :layout => @layout)

        page.slug = 'a-new-slug'
        page.save
        page.slug.should == 'a-new-slug'
      end
    end
  end
  
  describe "#process" do
    before :all do
      @dummy_request = ActionController::TestRequest.new
      @dummy_response = ActionController::TestResponse.new
    end
    
    it "should not raise an ImplementationError" do
      page = Page.new
      lambda { page.process(@dummy_request, @dummy_response) }.should_not raise_error
    end
    
    it "should return its body when there is no layout" do
      page = Page.new :mime => 'text/html', :body => 'hello world'
      page.process(@dummy_request, @dummy_response)
      @dummy_response.body.should == 'hello world'
      @dummy_response.content_type.should == 'text/html'
    end
    
    it 'should return repsonse code 200 by default' do
      page = Page.new :body => 'hello world'
      page.process(@dummy_request, @dummy_response)
      @dummy_response.response_code.should == 200
    end
  end
end