Rails.application.routes.draw do
  root 'games#index'

  resources :games, only: %i[] do
    collection do
      get :show
      post :create
      post :upload
    end
  end
end
