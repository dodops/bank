Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :accounts, only: [:create] do
    collection do
      get :balance
      post :transfer
    end
  end
end
