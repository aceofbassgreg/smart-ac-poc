class DevicesController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  def show
    @device = Device.find(params[:id])
  end

  def index
    @devices = Device.search(params[:serial_number]).sort_by(&:registration_date).reverse
  end

  private def devices_params
    params.require(:device).permit(:id, :serial_number, :registration_date, :firmware_version, :search)
  end
end
