#
# Rails routing guide: http://guides.rubyonrails.org/routing.html
#
ActionController::Routing::Routes.draw do |map|

  # routing-filter plugin magic!
  map.filter :locale

  # i18n database plugin
  map.from_plugin 'i18n_backend_database'


#  map.resources :password_resets
#
#  # activation TODO optimize routes
#  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
#  map.activate '/activate/:id', :controller => 'activations', :action => 'create'
#
#
#  map.resource :profile, :controller => "users", :member => [ :edit_profile => :get ]
#  # TODO optimize routes
##  map.edit_profile 'profile/edit', :controller => 'users', :action => 'edit_profile'
##  map.resource :profile, :controller => :users, :member => { :create => :post }
#
##  map.profile 'profile', :controller => :users, :action => :show
#
#  map.resource :account, :controller => "users"
#
#  map.resources :users
#
#
#  map.resource :user_session
#
#
#  # Join / Invite routes
#  map.interested_people 'interested_people', :controller => "join", :action => "new_interested"
##  map.invited_people 'invited_people', :controller => "join", :action => "new_invitation"
#
#

  map.with_options :controller => "join" do |join|
    join.join 'join', :action => 'new_interested'
#    join.invite 'invite', :action => 'new_invitation'
    join.create_interested 'create_interested', :action => 'create_interested', :method => :post
  end
#
  # Feedback route
  map.resources :feedback, :only => [:new, :create]

  
  # beta
#  map.locale "//", :controller => "static_content", :action => "echologic"
#
#  map.root :controller => 'static_content'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

#  map.resources :translations

  map.resource :user_session, :controller => 'users/user_sessions', :path_prefix => '', :only => [:new, :create, :destroy]

  map.resources :users, :controller => 'users/users', :path_prefix => ''

  map.resources :password_resets, :controller => 'users/password_resets', :path_prefix => '', :except => [:destroy]

  map.resource :profile, :controller => 'users/profile', :path_prefix => '', :only => [:show, :edit, :update]

  map.register '/register/:activation_code', :controller => 'users/activations', :action => 'new'
  map.activate '/activate/:id',              :controller => 'users/activations', :action => 'create'

 
  map.echo 'echo/:action', :controller => 'static/echo', :conditions => { :method => :get }
  map.echonomy 'echonomy/:action', :controller => 'static/echonomy', :conditions => { :method => :get }
  map.echocracy 'echocracy/:action', :controller => 'static/echocracy', :conditions => { :method => :get }
  map.echologic 'echologic', :controller => 'static/echologic', :action => 'index', :conditions => { :method => :get }
  map.static 'echologic/:action', :controller => 'static/echologic', :conditions => { :method => :get }

  map.root :controller => 'static/echologic', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
