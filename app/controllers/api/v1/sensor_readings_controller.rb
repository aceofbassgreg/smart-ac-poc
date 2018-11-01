module Api
  module V1
    class SensorReadingsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        puts params
      end

      def sensor_reading_params
        params.require('sensor_reading').permit(:carbon_monoxide_level, :air_humidity_percentage, :temperature)
      end
    end
  end
end
