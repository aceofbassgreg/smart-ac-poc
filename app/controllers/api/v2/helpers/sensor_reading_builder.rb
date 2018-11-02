module Api
  module V2
    module Helpers
      module SensorReadingBuilder

        def build_sensor_reading_and_handle_response(parameters)
          return false unless (parameters.dig(:carbon_monoxide_level) || 
            parameters.dig(:air_humidity_percentage) || 
            parameters.dig(:temperature) || 
            parameters.dig(:system_health)
          )
          sensor_reading = SensorReading.create(parameters.merge(device_id: device.id))
        end

        def device
          Device.find_by(serial_number: device_serial_number)
        end

        def device_serial_number
          current_user.email.split('@').first
        end
      end
    end
  end
end