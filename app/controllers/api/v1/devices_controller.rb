module Api
  module V1
    class DevicesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        device = Device.create(device_params)
        render json: device, status: 200
      end

      def device_params
        params.require('device').permit(:serial_number, :firmware_version)
      end
    end
  end
end
