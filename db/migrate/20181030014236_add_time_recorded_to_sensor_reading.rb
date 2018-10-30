class AddTimeRecordedToSensorReading < ActiveRecord::Migration[5.2]
  def change
    add_column :sensor_readings, :time_recorded, :timestamp
  end
end
