Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'tv_shows#index'
  namespace :api, as: nil, defaults: { format: 'json' } do
    namespace :v1, as: nil do
      resources :tv_shows
      resources :episodes
    end
  end
end
