Rails.application.routes.draw do
  get 'devices/create'
  get 'devices/show'
  get 'devices/index'
  root 'devices#index'
end
