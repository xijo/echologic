ActionController::Routing::Routes.draw do |map|

  # Join / Invite routes
  map.interested_people 'interested_people', :controller => "join", :action => "new_interested"
#  map.invited_people 'invited_people', :controller => "join", :action => "new_invitation"

  map.with_options :controller => "join" do |join|
    join.join 'join', :action => 'new_interested'
#    join.invite 'invite', :action => 'new_invitation'
    join.create_interested 'create_interested', :action => 'create_interested', :method => :post
  end
  
  # Feedback route
  map.resources :feedback, :only => [:new, :create]

  # Static content routes
  map.with_options :controller => 'static_content' do |static|
    
    # echologic - The Mission
    static.echologic 'echologic', :action => 'echologic'
    
    # echo - The Platform
    static.echo 'echo', :action => 'echo'
    static.echo_discuss 'echo/discuss', :action => 'echo_discuss'
    static.echo_connect 'echo/connect', :action => 'echo_connect'
    static.echo_act 'echo/act', :action => 'echo_act'
    static.echo_echo_on_waves 'echo/echo_on_waves', :action => 'echo_echo_on_waves'
    
    # echocracy - The Actors
    static.echocracy 'echocracy', :action => 'echocracy'
    static.echocracy_citizens 'echocracy/citizens', :action => 'echocracy_citizens'
    static.echocracy_scientists 'echocracy/scientists', :action => 'echocracy_scientists'
    static.echocracy_decision_makers 'echocracy/decision_makers', :action => 'echocracy_decision_makers'
    static.echocracy_organisations 'echocracy/organisations', :action => 'echocracy_organisations'
    
    # echonomy - The Values
    static.echonomy 'echonomy', :action => 'echonomy'
    static.echonomy_your_profit 'echonomy/your_profit', :action => 'echonomy_your_profit'
    static.echonomy_foundation 'echonomy/foundation', :action => 'echonomy_foundation'
    static.echonomy_public_property 'echonomy/public_property', :action => 'echonomy_public_property'
   

    # Top menu
    static.about 'about', :action => 'about'
    
    # Bottom menu
    static.imprint 'imprint', :action => 'imprint'
    static.data_privacy 'data_privacy', :action => 'data_privacy'
    
  end
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => 'static_content', :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  #map.maininfo 'static_content/:menu', :controller => "static_content", :action => :menu
  #map.subinfo 'static_content/:menu/:submenu', :controller => "static_content", :action => :menu + "_" + :submenu 
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

# Load german i18n file
#ActionController::Routing::Translator.i18n('es')
#ActionController::Routing::Translator.i18n('en')
#ActionController::Routing::Translator.i18n
ActionController::Routing::Translator.translate_from_file 'config/locales', 'i18n-routes.yml'