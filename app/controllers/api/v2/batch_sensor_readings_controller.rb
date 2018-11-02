module Api
  module V2
    class BatchSensorReadingsController < ApplicationController

      include Authenticator
      include Helpers::SensorReadingBuilder

      skip_before_action :verify_authenticity_token
      before_action :authenticate_api_user

      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        response = { reason: 'required parameter omitted', 'details': 'payload must have "sensor_readings" parameter' }
        respond_to do |format|
          format.json { render json: response, status: :unprocessable_entity }
        end
      end

      def create
        batch_sensor_reading_params.each do |sensor_reading|
          build_sensor_reading_and_handle_response(sensor_reading)
        end
        puts batch_sensor_reading_params.count
        render json: {'foo': 'ok'}, status: 200
      end

      private def batch_sensor_reading_params
        params.require('sensor_readings').map do |p|
          p.permit(
            :temperature, :carbon_monoxide_level, :device_health, :air_humidity_percentage
            )
        end
      end
    end
  end
end
