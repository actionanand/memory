Rails.application.routes.draw do
  
  root 'memories#index'
  resources :memories do
    resources :comments 
    member do
        put 'like', to: "memories#like"
        put 'unlike', to: "memories#unlike"
    end
  end
  
  resources :comments do
    resources :comments
  end
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
