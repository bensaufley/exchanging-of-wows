Rails.application.routes.draw do
  get 'portland', to: 'static_pages#portland', as: :portland

  namespace :admin, as: '', path: '' do
    resources :rsvps
  end
  root to: 'static_pages#home'
end
