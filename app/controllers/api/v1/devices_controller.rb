module Api
  module V1
    class DevicesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        puts "SUCCESS"
      end
    end
  end
end
