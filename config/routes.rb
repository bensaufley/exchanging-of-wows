Rails.application.routes.draw do
  get 'portland', to: 'static_pages#portland', as: :portland
  get 'jelena_ben', to: 'static_pages#jelena_ben', as: :jelena_ben

  namespace :admin, as: '', path: '' do
    resources :rsvps
  end
  root to: 'static_pages#home'
end
