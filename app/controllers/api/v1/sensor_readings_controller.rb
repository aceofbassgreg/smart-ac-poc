module Api
  module V1
    class SensorReadingsController < ApplicationController
      skip_before_action :verify_authenticity_token


      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        response = { reason: 'required parameter omitted', 'details': 'payload must include: {"device_attributes": {"serial_number": "SERIAL_NUMBER"}}' }
        respond_to do |format|
          format.json { render json: response, status: :unprocessable_entity }
        end
      end

      def create
        # unless sensor_reading_params.dig(:device_attributes)
        #   render json: {'reason': 'missing "device_attributes" key', 'details': 'you must specify "device_attributes" that points to object {"serial_number": SERIAL_NUMBER_HERE}'}, status: 400
        unless (device_attrs.dig(:carbon_monoxide_level) || 
          device_attrs.dig(:air_humidity_percentage) || 
          device_attrs.dig(:temperature) || 
          device_attrs.dig(:system_health)
        )
          render json: {'reason': 'no sensor data sent', 'details': ''}, status: 400
          return
        end
        sensor_reading = SensorReading.create(device_attrs.merge(device_id: device.id))
        render json: sensor_reading, status: 200
      rescue ActionController::ParameterMissing => e
        msg = e.match(/\(.+\)/).to_s.gsub(/[\(\)]/,'')
        render json: {'reason': msg, 'details': 'payload should include: {"device_attributes": {"serial_number": "SERIAL_NUMBER"}}'}, status: 400
      end

      private def device_attrs
        sensor_reading_params.except(:device_attributes)
      end

      private def device
        Device.find_by(serial_number: device_serial_number)
      end

      private def device_serial_number
        sensor_reading_params.dig(:device_attributes, :serial_number)
      end

      private def sensor_reading_params
        params.require('sensor_reading').permit(
          :carbon_monoxide_level, :air_humidity_percentage, :temperature, :device_health, 
          [device_attributes: [:serial_number]]
        ).tap { |sensor_params| sensor_params.require(:device_attributes) }
      end
    end
  end
end
