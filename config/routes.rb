Rails.application.routes.draw do
  get 'money/bank_statement' => 'money#bank_statement'
  get 'money/shopping_history' => 'money#shopping_history'
  get 'money/collection' => 'money#collection'
  get 'menu/index'
  get 'admin/login' => 'admin#login_form'
  get 'user/info' => 'user#user_info'
  get 'user/hope' => 'user#hope'
  post 'admin/login' => 'admin#login'
  post 'admin/logout' => 'admin#logout'
  get 'admin/index' => 'admin#admin_user_index'

  get '/' => 'admin#login_form'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
