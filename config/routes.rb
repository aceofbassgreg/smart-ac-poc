Rails.application.routes.draw do
  devise_for :users
  get 'devices/create'
  get 'devices/show'
  get 'devices/index'
  root 'devices#index'
end
