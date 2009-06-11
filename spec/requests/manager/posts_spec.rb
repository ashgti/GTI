require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

given "a post exists" do
  Post.all.destroy!
  5.times do |t|
    p = Post.make
    p.id = t
    p.save
  end
end

given "user logged in" do
  User.all.destroy!
  User.gen :admin
  @response = request(url(:perform_login), :method => "POST", 
    :params => { :'_method' => 'PUT', :login => 'admin', :password => 'password', :'Submit' => 'Log In'})
end

describe "resource(:manager, :posts)", :given => "user logged in" do
  describe "GET" do
    before(:each) do
      @response = request(resource(:manager, :posts))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of posts" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a post exists" do
    before(:each) do
      @response = request(resource(:manager, :posts))
    end
    
    it "has a list of posts" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Post.all.destroy!
      @response = request(resource(:manager, :posts), :method => "POST", 
             :params => { :post => { :title => "test", :slug => "test" }})
    end
    
    it "redirects to resource(:manager, :posts)" do
      @response.should redirect_to(resource(:manager, Post.first), :message => {:notice => "post was successfully created"})
    end
    
  end
end

describe "resource(:manager, @post)" do 
  describe "a successful DELETE", :given => "a post exists" do
     before(:each) do
       @response = request(resource(Post.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:posts))
     end

   end
end

describe "resource(:posts, :new)" do
  before(:each) do
    @response = request(resource(:posts, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@post, :edit)", :given => "a post exists" do
  before(:each) do
    @response = request(resource(Post.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@post)", :given => "a post exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Post.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @post = Post.first
      @response = request(resource(@post), :method => "PUT", 
        :params => { :post => {:id => @post.id} })
    end
  
    it "redirect to the post show action" do
      @response.should redirect_to(resource(@post))
    end
  end
  
end

