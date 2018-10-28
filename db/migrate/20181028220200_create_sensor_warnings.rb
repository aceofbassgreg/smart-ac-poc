class CreateSensorWarnings < ActiveRecord::Migration[5.2]
  def change
    create_table :sensor_warnings do |t|
      t.integer :warning_type
      t.boolean :resolved
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
