#map.resources :locales, :has_many => :translations
map.resources :locales do |locale|
  locale.resources :translations
end

map.translations '/translations', :controller => 'translations', :action => 'translations'
map.asset_translations '/asset_translations', :controller => 'translations', :action => 'asset_translations'
map.filter_translations 'translations/filter', :controller => 'translations', :action => 'filter'
