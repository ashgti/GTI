require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe User do
  before :each do
    User.all.destroy!
    Post.all.destroy!
  end
  
  describe "Associations" do
    describe "#posts" do
      it "should have many" do
        a = User.gen :admin
        5.times do 
          Post.gen
        end
        a.posts.count.should == 5
        Post.all('owner.id' => a.id).count.should == 5
      end
    end
  end
end
