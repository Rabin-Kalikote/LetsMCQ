Rails.application.routes.draw do

  resources :grounds, param: :name do
    member do
      get "join", to: "grounds#join"
      get "start", to: "grounds#start"
      get "leave", to: "grounds#leave"
      get "score", to: "grounds#score"
    end
  end
  devise_for :users
  root to: "grounds#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
