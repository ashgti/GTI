module Manager
  class Admin < ::Application
    layout :admin
    
    before do
      self.scripts = ['jquery', 'app']
      self.stylesheets = ['admin/screen']
    end
  end
end
