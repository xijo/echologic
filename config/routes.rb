#
# Rails routing guide: http://guides.rubyonrails.org/routing.html
#
ActionController::Routing::Routes.draw do |map|

  # routing-filter plugin for wrapping :locale around urls and paths.
  map.filter :locale

  # SECTION i18n
  map.resources :locales, :controller => 'i18n/locales' do |locale|
    locale.resources :translations, :controller => 'i18n/translations'
  end
  map.translations '/translations', :controller => 'i18n/translations', :action => 'translations'
  map.asset_translations '/asset_translations', :controller => 'i18n/translations', :action => 'asset_translations'
  map.filter_translations 'translations/filter', :controller => 'i18n/translations', :action => 'filter'

  # SECTION join - depricated
  map.with_options :controller => "join" do |join|
    join.join 'join', :action => 'new_interested'
    join.create_interested 'create_interested', :action => 'create_interested', :method => :post
  end

  # SECTION feedback
  map.resources :feedback, :only => [:new, :create]

  
  # SECTION user signup and login
  map.resource  :user_session, :controller => 'users/user_sessions',
                :path_prefix => '', :only => [:new, :create, :destroy]

  map.resources :users, :controller => 'users/users', :path_prefix => '' do |user|
    user.resources :web_profiles, :controller => 'users/web_profiles', :except => [:index]
    user.resources :activities,   :controller => 'users/activities',   :except => [:index]
    user.resources :memberships,  :controller => 'users/memberships',  :except => [:index]
  end
  map.resources :password_resets, :controller => 'users/password_resets',
                :path_prefix => '', :except => [:destroy]
  map.resource  :profile, :controller => 'users/profile',
                :path_prefix => '', :only => [:show, :edit, :update]
  map.register  '/register/:activation_code',
                :controller => 'users/activations', :action => 'new'
  map.activate  '/activate/:id',
                :controller => 'users/activations', :action => 'create'

  # SECTION static - contents per controller
  map.echo 'echo/:action', :controller => 'static/echo',
           :conditions => { :method => :get }
  map.echonomy 'echonomy/:action', :controller => 'static/echonomy',
           :conditions => { :method => :get }
  map.echocracy 'echocracy/:action', :controller => 'static/echocracy',
           :conditions => { :method => :get }
  map.echologic 'echologic', :controller => 'static/echologic', :action => 'index',
           :conditions => { :method => :get }
  map.static 'echologic/:action', :controller => 'static/echologic',
           :conditions => { :method => :get }

  # SECTION root
  map.root :controller => 'static/echologic', :action => 'index'

  # SECTION default routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
