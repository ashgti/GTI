# task :merb_start do
#   Merb.start_environment :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'development'
# end

desc 'Setup default user.'
task :setup => :environment do 
  admin_user = User.new
  
  defaults = {
    :email => 'admin@example.com',
    :login => 'admin',
    :password => 'password',
    :settings => 'default_settings',
    :layout => 'default_layout.html',
    :pages => 'default_pages'
  }
  
  
  if ask("Load all defaults? (y/n)", 'y') == 'y'
    admin_user.email = defaults[:email]
    admin_user.login = defaults[:login]
    admin_user.password = admin_user.password_confirmation = defaults[:password]
    admin_user.save
    load_settings defaults[:settings]
    load_layout defaults[:layout]
    load_pages defaults[:pages]
  else
    begin
      admin_user.errors.each {|e| puts e} if admin_user.errors
      admin_user.email = ask 'Admin Email: ', defaults[:email]
      admin_user.login = ask 'Admin Login: ', defaults[:login]
      password = password_confirmation = ''
      begin
        if password != password_confirmation
          puts 'error'
        end
        password = ask 'Admin Password: ', defaults[:password]
        password_confirmation = ask 'Confirm Password: ', defaults[:password]
      end while (password != password_confirmation)
      admin_user.password = password
      admin_user.password_confirmation = password_confirmation
    
      load_settings defaults[:settings] if (ask "Load default settings? (y/n)", 'y') == 'y'
      load_layout defaults[:layout] if (ask "Load default layout? (y/n)", 'y') == 'y'
      load_pages defaults[:pages] if (ask "Load default pages? (y/n)", 'y') == 'y'
    end while not admin_user.save
  end
end


def load_settings filename
  # settings = YAML.load_file(File.join(File.dirname(__FILE__), filename+'.yml'))
  # 
  # settings.each_pair do |type, auto_loads| 
  #   auto_loads.each_pair do |auto, values| 
  #     auto_load = (auto == :auto_load)
  #     values.each_pair do |key, value|
  #       setting = Setting.new(:key => key, :value => value, :type => type, :auto_load => auto_load)
  #       setting.save
  #     end
  #   end
  # end
end

def load_pages defaults = nil
  page = Page.new
  page.root = true
  page.title = 'Home Page'
  page.body = 'Hello World!'
  page.slug = '/'
  page.root = true
  page.layout = Layout.first
  page.owner = User.first
  if page.valid?
    page.save
  else
    p page.errors
  end
end

def load_layout filename
  layout = Layout.new
  layout.name = 'default'
  default_layout = File.new(Rails.root.join('lib', 'tasks', filename), 'r')
  layout.body  = default_layout.read
  if layout.valid?
    layout.save
  else
    p layout.errors
  end
end
