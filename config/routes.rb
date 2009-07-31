ActionController::Routing::Routes.draw do |map|
  map.namespace :manager, :member => { :remove => :get } do |admin|
    admin.resources :pages do |pages|
      pages.resources :children, :controller => "pages"
    end
    admin.resources :posts do |posts|
      posts.resources :comments
    end
    admin.resources :layouts
    admin.resources :snippets
    admin.resources :layouts
    admin.resources :chunks
    admin.resources :users
  end
 
  map.namespace :manager do |admin|
    admin.resource :preferences
    admin.resources :extensions
    admin.resources :page_parts
    admin.resources :references
  end
 
  # Admin Routes
  map.with_options(:controller => 'manager/welcome') do |welcome|
    welcome.admin          'manager',                              :action => 'index'
    welcome.welcome        'manager/welcome',                      :action => 'index'
    welcome.login          'manager/login',                        :action => 'login'
    welcome.logout         'manager/logout',                       :action => 'logout'
  end
 
  # Site URLs
  map.with_options(:controller => 'blogger') do |site|
    site.root                                                    :action => 'show_page', :url => '/'
    site.not_found         'error/404',                          :action => 'not_found'
    site.error             'error/500',                          :action => 'error'
 
    site.connect           'ajax/*url',                          :aciton => 'ajax_response'
    # Everything else
    site.connect           '*url',                               :action => 'show_page'
  end
 
  # map.namespace :manager do |admin|
  #   admin.resources :posts
  # end
  # 
  # map.connect '/login', :controller => 'session', :action => 'new'
  # map.connect '/logout', :controller => ''
  # 
  # map.root :controller => "blogger"

end
