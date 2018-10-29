class DevicesController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  def show
  end

  def index
    @devices = Device.search(params[:serial_number])
  end

  private def devices_params
    params.require(:device).permit(:serial_number, :registration_date, :firmware_version, :search)
  end
end
