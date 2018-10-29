Rails.application.routes.draw do
  get 'sensor_readings/create'
  get 'sensor_readings/index'
  get 'sensor_readings/show'
  devise_for :users
  get 'devices/create'
  get 'devices/show'
  get 'devices/index'
  root 'devices#index'
end
