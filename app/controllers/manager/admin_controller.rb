module Manager
  class AdminController < ::ApplicationController
    def initialize
      @scripts = ['jquery-1.3.2.min', 'app']
      @styles = ['admin/screen']
    end
  end
end
