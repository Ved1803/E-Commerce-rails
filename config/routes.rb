Rails.application.routes.draw do
  get 'cart_items/create'
  get 'cart_items/destroy'
  get 'carts/show'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :collections
  resource :cart, only: [:show] do
    resources :cart_items, only: [:create, :show, :index, :destroy, :update]
  end
end
