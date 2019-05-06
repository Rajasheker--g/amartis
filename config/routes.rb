Rails.application.routes.draw do
  get 'teacher_dashboard/index'

  get 'parent_dashboard/index'

	devise_for :users, :controllers => {:registrations => "registrations"}
  
  devise_scope :user do
    get "registrations/index" => "registrations#index", as: :show_users
    get "registrations/new_user" => "registrations#new_user", as: :new_user
    get "registrations/:id/edit_user" => "registrations#edit_user", as: :edit_user

    authenticated :user do
  		root 'parent_dashboard#index', as: :authenticated_root
	  end

	  unauthenticated do
	    root 'devise/sessions#new', as: :unauthenticated_root
	  end
	end
  resources :addresses
  resources :organisations
  resources :students
  resources :teachers
  resources :parents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
