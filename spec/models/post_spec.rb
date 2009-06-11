require File.join(File.dirname(__FILE__), '..', "spec_helper")

describe Post do
  before :all do
    User.all.destroy! 
    @user = User.gen :admin
  end
  
  before :each do
    Post.all.destroy!
  end
  
  describe "Validations" do
    describe "#title" do
      it "should not be valid" do
        post = Post.new
        post.should_not be_valid
        post.errors[:title].should_not be_nil
        post.errors[:title].should_not be_empty
      end

      it "should be valid" do
        post = Post.new
        post.title = 'Hello World'
        post.slug = 'hello-world'
        post.owner = @user
        post.should be_valid
      end
    end
    
    describe "#slug" do
      it "should be valid" do
        post = Post.new
        post.title = 'Hello World'
        post.slug = 'Hello World'
        post.owner = @user
        post.should be_valid
        post.save.should be true
        saved_post = Post.first
        saved_post.slug.should == 'hello-world'
      end
      
      it "should be unique" do
        Post.new(:title => 'Hello World', :owner => @user, :slug => 'hello-world').save

        post = Post.new
        post.title = 'Hello World'
        post.slug = 'hello-world'
        post.owner = @user
        
        post.should_not be_valid
        post.errors[:slug].should_not be_nil
        post.errors[:slug].should_not be_empty
        post.errors[:slug][0].should == 'Slug is already taken'
      end
    end
  end
end