Rails.application.routes.draw do
  
  #para eliminar un recurso del resource
  #resources :categories, except: :show
  resources :categories

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  ##delete '/products/:id', to: 'products#destroy'
  ##patch '/products/:id', to: 'products#update'
  ##post '/products', to: 'products#create'
  ##get '/products/new', to: 'products#new', as: :new_product

  # Defines the root path route ("/")
  # root "articles#index"
  #method resource to controller(products) function index 
  ##get '/products', to: 'products#index'

  #ruta para mostrar un producto en especificop con parametro id 
  # as: :product metodo helper que resuelva la ruta, para que no tengamos que colocar la url completa
  #vamos a recibir un parametro dinamico de id
  ##get '/products/:id', to: 'products#show', as: :product
  ##get '/products/:id/edit', to: 'products#edit', as: :edit_product

  #agregamos el path: '/' par se lista los productos desde la home  
  resources :products, path: '/'  
end
