class SensorReadingsController < ApplicationController
  def create
  end

  def index
    device_id = params[:device_id]
    @device = Device.find(device_id)
    @sensor_readings = SensorReading.search(params[:device_id])
  end

  def show
  end

  private def sensor_readings_params
    params.require(:sensor_reading).permit(
      :temperature, :carbon_monoxide_level, :air_humidity_percentage,
      :device_health, :device_id
    )
  end
end
