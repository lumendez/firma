Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  scope "/admin" do
    resources :users
  end
  resources :roles
  resources :users
  resources :constancia_documentos do
    collection do
      get 'firmar'
      get 'imprimir/:id', to: 'constancia_documentos#imprimir',  as: 'imprimir'
    end
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
