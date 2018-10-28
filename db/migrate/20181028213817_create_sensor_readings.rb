class CreateSensorReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :sensor_readings do |t|
      t.integer :temperature
      t.decimal :carbon_monoxide_level
      t.decimal :air_humidity_percentage
      t.string :device_health
      t.references :device

      t.timestamps
    end
  end
end
