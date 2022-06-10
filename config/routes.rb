Rails.application.routes.draw do

  resources :messages
  resources :grounds, param: :name do
    member do
      get "join", to: "grounds#join"
      get "start", to: "grounds#start"
      get "leave", to: "grounds#leave"
      get "score", to: "grounds#score"
    end
  end
  devise_for :users, controllers: { sessions: "sessions" }
  root to: "grounds#index"
  get "bad", to: "pages#bad"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
