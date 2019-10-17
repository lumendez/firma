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
  # Antes de param para que no se envie en parameters
  resources :constancia_documentos, param: :uuid do
    collection do
      get 'firmar'
      get 'imprimir/:uuid', to: 'constancia_documentos#imprimir',  as: 'imprimir'
      post 'actualizar_firma'
    end
  end
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
