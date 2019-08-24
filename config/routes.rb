Rails.application.routes.draw do
  resources :constancia_documentos do
    collection do
      get 'firmar'
      get 'imprimir/:id', to: 'constancia_documentos#imprimir',  as: 'imprimir'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
