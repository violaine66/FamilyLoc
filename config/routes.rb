Rails.application.routes.draw do
  namespace :admin do
    resources :reservations, only: [:index, :show, :destroy]
    resources :exports, only: [:index] do
      collection do
        get :reservations
      end
    end
  end
  
  devise_for :users
  root to: "pages#home"
  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
   get '/reservations/calendar', to: 'reservations#calendar', as: 'calendar_reservations'

  resources :proprietes do
    resources :reservations, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :reservations, only: [:index, :show ]
  resources :reservations do
    member do
      patch :update_statut
    end
  end
end
