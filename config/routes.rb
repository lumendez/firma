Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions'}
  scope "/admin" do
    resources :users
  end
  resources :roles
  resources :users do
    member do
      post :enable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_enable'
      post :disable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_disabled'
    end
  end
  resources :constancia_documentos, param: :uuid
  resources :constancia_documentos do
    collection do
      get 'firmar'
      get 'imprimir/:uuid', to: 'constancia_documentos#imprimir',  as: 'imprimir'
    end
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
