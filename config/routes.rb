Rails.application.routes.draw do
  get 'money/bank_statement' => 'money#bank_statement'
  get 'money/shopping_history' => 'money#shopping_history'
  get 'money/collection' => 'money#collection'
  post 'money/new' => 'money#new'
  get 'money/new' => 'money#new'
  post 'money/create' => 'money#create'
  get 'money/:id/edit' => 'money#edit'
  post 'money/:id/edit' => 'money#edit'
  post 'money/:id/update' => 'money#update'
  
  get 'menu/index'
  get 'admin/login' => 'admin#login_form'
  get 'user/info' => 'user#user_info'
  get 'user/hope' => 'user#hope'
  post 'user/new' => 'user#new'
  post 'user/create' => 'user#create'
  post 'user/:id/edit' => 'user#edit'
  post 'user/:id/update' => 'user#update'
  post 'user/:id/destroy' => 'user#destroy'

  post 'admin/login' => 'admin#login'
  post 'admin/logout' => 'admin#logout'
  get 'admin/index' => 'admin#admin_user_index'
  post 'admin/new' => 'admin#new'
  post 'admin/create' => 'admin#create'
  post 'admin/:id/edit' => 'admin#edit'
  post 'admin/:id/update' => 'admin#update'

  get '/' => 'admin#login_form'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
