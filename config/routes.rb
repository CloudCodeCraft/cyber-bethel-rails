Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "users/create" => "users#create"
  get "users/show" => "users#show"
  post "login" => "sessions#login"
  delete "logout" => "sessions#logout"
  get "sessions/show" => "sessions#show"
  get "sessions" => "sessions#index"
  delete "sessions/purge" => "sessions#purge"

  scope :prayer_requests do
    get "" => "prayer_requests#index"
    post "" => "prayer_requests#create"
  end
end
