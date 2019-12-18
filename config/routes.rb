Rails.application.routes.draw do

  #メニュー
  get 'menu/index'
  #入出金管理、買い出し登録
  get 'money/index' => 'money#index'
  post 'money/new' => 'money#new'
  get 'money/new' => 'money#new'
  post 'money/create' => 'money#create'
  get 'money/:id/edit' => 'money#edit'
  post 'money/:id/edit' => 'money#edit'
  post 'money/:id/update' => 'money#update'

  #徴収
  post 'collect/index' => 'collect#index'
  get 'collect/index' => 'collect#index'
  post 'collect/:id/new' => 'collect#new'
  get 'collect/:id/new' => 'collect#new'
  post 'collect/:id/show' => 'collect#show'
  get 'collect/:id/show' => 'collect#show'
  post 'collect/:id/create' => 'collect#create'

  #請求
  post 'claim/new' => 'claim#new'
  get 'claim/new' => 'claim#new'
  post 'claim/create' => 'claim#create'
  
  #個人履歴
  get 'user_history/:id/index' => 'user_history#index'
  post 'user_history/:id/edit' => 'user_history#edit'
  get 'user_history/:id/edit' => 'user_history#edit'
  post 'user_history/:id/update' => 'user_history#update'
  
  
  post 'money/choice' => 'money#choice'
  get 'money/exp_csv' => 'money#exp_csv'
  post 'money/exp_csv' => 'money#exp_csv'

  get 'admin/login' => 'admin#login_form'
  get 'user/info' => 'user#user_info'
  post 'user/new' => 'user#new'
  get 'user/new' => 'user#new'
  post 'user/create' => 'user#create'
  post 'user/:id/edit' => 'user#edit'
  post 'user/:id/update' => 'user#update'
  post 'user/:id/destroy' => 'user#destroy'

  get 'hope/index' => 'hope#index'
  post 'hope/new' => 'hope#new'
  get 'hope/:id/edit' => 'hope#edit'
  post 'hope/:id/edit' => 'hope#edit'
  post 'hope/create' => 'hope#create'
  post 'hope/:id/update' => 'hope#update'
  post 'hope/:id/destroy' => 'hope#destroy'

  post 'admin/login' => 'admin#login'
  post 'admin/logout' => 'admin#logout'
  get 'admin/index' => 'admin#admin_user_index'
  post 'admin/new' => 'admin#new'
  post 'admin/create' => 'admin#create'
  post 'admin/:id/edit' => 'admin#edit'
  get 'admin/:id/edit' => 'admin#edit'
  post 'admin/:id/update' => 'admin#update'

  get '/' => 'admin#login_form'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
