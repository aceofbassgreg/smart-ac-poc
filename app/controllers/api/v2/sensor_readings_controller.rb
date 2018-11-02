module Api
  module V2
    class SensorReadingsController < ApplicationController

      include Authenticator

      skip_before_action :verify_authenticity_token
      before_action :authenticate_api_user

      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        response = { reason: 'required parameter omitted', 'details': 'payload must have ANY of the following keys:  tmeperature, carbon_monoxide_level, device_health, air_humidity_percentage. No other parameteres  are permitted' }
        respond_to do |format|
          format.json { render json: response, status: :unprocessable_entity }
        end
      end

      def create
        unless (sensor_reading_params.dig(:carbon_monoxide_level) || 
          sensor_reading_params.dig(:air_humidity_percentage) || 
          sensor_reading_params.dig(:temperature) || 
          sensor_reading_params.dig(:system_health)
        )
          render json: {'reason': 'no sensor data sent', 'details': ''}, status: 400
          return
        end
        sensor_reading = SensorReading.create(sensor_reading_params.merge(device_id: device.id))
        render json: sensor_reading, status: 200
      end

      private def device
        Device.find_by(serial_number: device_serial_number)
      end

      private def device_serial_number
        current_user.email.split('@').first
      end

      private def sensor_reading_params
        params.require('sensor_reading').permit(
          :carbon_monoxide_level, :air_humidity_percentage, :temperature, :device_health, :time_recorded
        )
      end
    end
  end
end
