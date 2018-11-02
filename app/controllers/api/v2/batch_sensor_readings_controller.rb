module Api
  module V2
    class BatchSensorReadingsController < ApplicationController

      include Helpers::Authenticator
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
        errors = []
        success = []
        batch_sensor_reading_params.each do |sensor_reading|
          if build_sensor_reading_and_handle_response(sensor_reading)
            success << sensor_reading
            next
          else
            errors << sensor_reading
          end
        end

        if errors.empty?
          render json: {'records_created': success.count}, status: 200
        elsif success.empty?
          render json: {'reason': 'no valid records sent', 'details': errors, status: 422}
        else
          render json: {'records_created': success.count, 'error_count': errors.count, 'reason': 'invalid sensor_readings sent', 'details': errors}, status: 200
        end
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
