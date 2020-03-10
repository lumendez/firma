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
      get 'validar'
      get 'validar_constancias'
      get 'imprimir/:uuid', to: 'constancia_documentos#imprimir',  as: 'imprimir'
      post 'actualizar_firma'
      get 'buscar_relacion'
      get 'relacion'
      get 'imprimir_relacion', to: 'constancia_documentos#imprimir_relacion', as: 'imprimir_relacion'
    end
  end
  devise_scope :user do
    root to: "devise/sessions#new"
  end


  get 'get_info_alumno/:q' => 'constancia_documentos#get_info_alumno'

  get 'get_info_curp/:q' => 'constancia_documentos#get_info_curp'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
