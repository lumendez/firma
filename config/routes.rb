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

  resources :constancia_documentos, param: :uuid do
    collection do
      post 'firmar'
      get 'validar'
      get 'validar_constancias'
      get 'imprimir/:uuid', to: 'constancia_documentos#imprimir', as: 'imprimir'
      post 'actualizar_firma'
      get 'buscar_relacion'
      get 'relacion'
      get 'imprimir_relacion', to: 'constancia_documentos#imprimir_relacion', as: 'imprimir_relacion'
      get 'constancias_firmadas'
      #SE AGREGAN RUTAS PARA CARGAR CSV
       get 'cargar_archivo', to: 'constancia_documentos#cargar_archivo', as: 'cargar_archivo'
       post 'importar_csv', to: 'constancia_documentos#importar_csv', as: 'importar_csv'
      #SE AGREGA RUTA PARA EXPORTAR ARCHIVO CSV 
       get :exportar_csv
    end
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get 'get_info_alumno/:q' => 'constancia_documentos#get_info_alumno'
  get 'get_info_curp/:q' => 'constancia_documentos#get_info_curp'
end
