Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :contacts do
    get "generate_vcard"
    get "generate_vcards"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated do
    root to: 'contacts#index'
  end
  root to: redirect('/users/sign_in')
end
