Rails.application.routes.draw do
  get 'portland', to: 'static_pages#portland', as: :portland
  get 'jelena_ben', to: 'static_pages#jelena_ben', as: :jelena_ben

  namespace :admin, as: '', path: '' do
    get 'song_requests/search', to: 'song_requests#search', as: :song_request_search
    resources :rsvps, only: [:index, :create, :edit, :update, :destroy] # No show or new
    resources :song_requests
  end
  root to: 'static_pages#home'
end
