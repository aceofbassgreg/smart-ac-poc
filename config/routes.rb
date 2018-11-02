Rails.application.routes.draw do
  get 'sensor_readings/create'
  get 'sensor_readings/index'
  get 'sensor_readings/show'
  devise_for :users
  resources :devices, only: [:index, :show]
  root 'devices#index'
  namespace 'charts' do
    namespace 'devices' do
      get ':id/temperature', action: :show_temperature
      get ':id/carbon_monoxide_level', action: :show_carbon_monoxide_level
      get ':id/air_humidity_percentage', action: :show_air_humidity_percentage
    end
  end

  namespace 'api' do
    namespace 'v1' do
      resources :devices, only: [:create]
      resources :sensor_readings, only: [:create]
    end
  end

  namespace 'api' do
    namespace 'v2' do
      resources :devices, only: [:create]
      resources :sensor_readings, only: [:create]
      resources :batch_sensor_readings, only: [:create]
    end
  end
end
