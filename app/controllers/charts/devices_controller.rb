module Charts
  class DevicesController < ApplicationController
    def show_temperature
      json_to_render = value_hashes(:temperature)
      puts json_to_render
      render json: json_to_render
    end

    def show_carbon_monoxide_level
      json_to_render = value_hashes(:carbon_monoxide_level)
      render json: json_to_render
    end

    def show_air_humidity_percentage
      json_to_render = value_hashes(:air_humidity_percentage)
      render json: json_to_render
    end

    private def device_sensor_readings
      Device.find(params[:id]).sensor_readings.all.sort_by(&:time_recorded).reverse
    end

    private def value_hashes(param)
      h = Hash.new
      device_sensor_readings.map do |sensor_reading|
        h[sensor_reading.time_recorded.to_datetime.to_s] = sensor_reading.send(param)
      end
      h
    end
  end
end
