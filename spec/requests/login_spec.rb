require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "url(:login)" do
  describe "GET" do
    before(:each) do
      @response = get(:login, { :username => '5'})
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "should display the form to login" do
      @response.should have_selector("form[action='#{url(:perform_login)}'][method='POST']")
      @response.should have_selector("input#login[name='login'][type='text']") 
      @response.should have_selector("input#password[name='password'][type='password']") 
    end
  end
  
  describe "POST" do
    before(:each) do
      User.all.destroy!
      User.gen :admin
    end
    
    it "redirects to the home page with back history" do
      response = request(url(:perform_login), :method => "POST", 
        :params => { :'_method' => 'PUT', :login => 'admin', :password => 'password', :'Submit' => 'Log In'})
      response.should redirect_to(url(:home))
    end
    
    it "redirects to the page requested if authentication is requred" do
      request(url(:manager_home))
      response = request(url(:perform_login), :method => "POST", 
        :params => { :'_method' => 'PUT', :login => 'admin', :password => 'password', :'Submit' => 'Log In'})
      response.should redirect_to(url(:manager_home))      
    end
  end
end


describe '#new' do
  it "should default to the US country id" do
    get :new
    response.should render_template('new')
    response.body.should have_tag("select#user_country_id") do |elem|
      with_tag "option[value=US][selected=selected]"
    end
  end
end