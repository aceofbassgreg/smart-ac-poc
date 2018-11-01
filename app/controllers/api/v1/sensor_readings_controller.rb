module Api
  module V1
    class SensorReadingsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        device_serial_number = sensor_reading_params[:device_attributes][:serial_number]
        device = Device.find_by(serial_number: device_serial_number)
        attrs = sensor_reading_params.except(:device_attributes)
        sensor_reading = SensorReading.create(attrs.merge(device_id: device.id))
        render json: sensor_reading, status: 200
      end

      def sensor_reading_params
        params.require('sensor_reading').permit(
          :carbon_monoxide_level, :air_humidity_percentage, :temperature, [
            device_attributes: [:serial_number]]
        )
      end
    end
  end
end
