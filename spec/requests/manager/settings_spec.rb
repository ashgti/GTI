require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe "/manager/settings" do
  before(:each) do
    @response = request("/manager/settings")
  end
end