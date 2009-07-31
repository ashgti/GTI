Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = 'BloggerController'
end

# Setup Session Serialization
Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id| 
  User.get(id)
end

# Basic password based strategy 
Warden::Strategies.add(:password) do
  def valid?
    params["password"] || params["login"]
  end
  
  def authenticate!
    u = User.authenticate(params["email"], params["password"])
    u.nil? ? fail!("Could not log in") : success!(u)
  end  
end