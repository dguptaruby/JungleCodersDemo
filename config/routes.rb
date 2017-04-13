Rails.application.routes.draw do
  devise_for :users
  resources :contacts do
		get "generate_vcard"
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated do
  	root to: "contacts#index"
  end
  root to: redirect("/users/sign_in")
end
