module Api
  module V1
    class DevicesController < ApplicationController
      skip_before_action :verify_authenticity_token

      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        response = { reason: 'required parameter omitted', 'details': 'payload must include "serial_number" and "firmware_version"' }
        respond_to do |format|
          format.json { render json: response, status: :unprocessable_entity }
        end
      end

      def create
        device = Device.create(device_params)
        render json: device, status: 200
      rescue ActiveRecord::RecordNotUnique
        render json: {'reason': "serial number #{device_params[:serial_number]} is already registered", 'details': ''}, status: 422
      end

      def device_params
        params.require('device').permit(:serial_number, :firmware_version).tap do |device_attrs|
          device_attrs.require(:serial_number)
          device_attrs.require(:firmware_version)
        end
      end
    end
  end
end
