require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a few post exists" do
  Post.all.destroy!
  5.times do |t|
    p = Post.make
    p.id = t
    p.save
  end
end

given 'no posts exist' do
  Post.all.destroy!
end

describe "url(:posts)", :type => :integration do
  describe "GET" do
    before(:each) do
      visit root_path
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of posts", :given => 'no posts exist' do
      @response.should have_selector("div.notice.not_articles")
    end
  end
end

describe "url(:posts)", :given => "a few post exists" do
  describe "GET" do
    before(:each) do
      @response = request(url(:posts))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of posts" do
      @response.should have_selector("div.post_listing")
    end
    
  end
end

describe "url(:post, @post)", :given => "a few post exists" do
  describe "GET" do
    before(:each) do
      @response = request(url(:post, :slug => Post.first.slug))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
end

