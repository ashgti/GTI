task :merb_start do
  Merb.start_environment :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'development'
end

desc 'Setup default user.'
task :setup => :merb_start do 
  admin_user = User.new
  begin
    admin_user.errors.each {|e| puts e} if admin_user.errors
    admin_user.email = ask 'Admin Email: ', 'admin@example.com'
    admin_user.login = ask 'Admin Login: ', 'admin'
    password = password_confirmation = ''
    begin
      if password != password_confirmation
        puts 'error'
      end
      password = ask 'Admin Password: ', 'password'
      password_confirmation = ask 'Confirm Password: ', 'password'
    end while (password != password_confirmation)
    admin_user.password = password
    admin_user.password_confirmation = password_confirmation
    
    load_settings 'default_settings' if (ask "Load default settings? (y/n)", 'y') == 'y'
  end while not admin_user.save
end


def load_settings filename
  settings = YAML.load_file(File.join(File.dirname(__FILE__), filename+'.yml'))
  
  settings.each_pair do |type, auto_loads| 
    auto_loads.each_pair do |auto, values| 
      auto_load = (auto == :auto_load)
      values.each_pair do |key, value|
        setting = Setting.new(:key => key, :value => value, :type => type, :auto_load => auto_load)
        setting.save
      end
    end
  end
end