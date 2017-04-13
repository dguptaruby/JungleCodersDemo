Rails.application.routes.draw do
  resources :contacts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated do
  	root to: "contacts#index"
  end
  root to: redirect("/users/sign_in")
end
