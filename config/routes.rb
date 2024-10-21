Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "homes#top"
  resources :users do
    resource :relationships
    get "followings"=>"relationships/followings",as: "followings"
    get "followers"=>"relationships/followers",as: "followers"
  end
  resources :posts do
    resource :favorites

  end


end
