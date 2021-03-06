Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  mount Api::Document => '/'
  mount Api::DocumentSettings => '/'
  mount Api::DocumentFilters => '/'
  mount Api::ExtensionSettings => '/'
  
  root to: 'index#show'
  
end
