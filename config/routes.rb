Rails.application.routes.draw do
  devise_for :clients, skip: [:registrations]
  as :client do
    get 'clients/edit' => 'devise/registrations#edit', :as => 'edit_client_registration'
    put 'clients' => 'devise/registrations#update', :as => 'client_registration'
  end

  devise_for :staffs, skip: [:registrations]
  as :staff do
    get 'staffs/edit' => 'devise/registrations#edit', :as => 'edit_staff_registration'
    put 'staffs' => 'devise/registrations#update', :as => 'staff_registration'
  end

  root to: "home#index"

  namespace :client do
    root to: "home#index"
    resources :home, only: :index
  end

  namespace :staff do
    root to: "home#index"
    resources :home, only: :index
  end
end
