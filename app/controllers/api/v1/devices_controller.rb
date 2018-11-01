module Api
  module V1
    class DevicesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        device = Device.create(device_params)
        render json: device, status: 200
      rescue ActiveRecord::NotNullViolation => e
        details = e.message.gsub('PG::NotNullViolation: ERROR:  ','').gsub(/\n.+/,'')
        render json: {'reason': 'required field omitted', 'details': details}, status: 422
      rescue ActiveRecord::RecordNotUnique
        render json: {'reason': "serial number #{device_params[:serial_number]} is already registered", 'details': ''}, status: 422
      end

      def device_params
        params.require('device').permit(:serial_number, :firmware_version)
      end
    end
  end
end
