Collection::Application.routes.draw do
  devise_for :users
 
  resources :items
  root :to => "items#index"
  
  resources :item_types
  resources :creator_types
  resources :books
  resources :metadata do 
    resources :items
    resources :books
  end

  resources :creators do
    resources :items
    resources :books
  end
end
