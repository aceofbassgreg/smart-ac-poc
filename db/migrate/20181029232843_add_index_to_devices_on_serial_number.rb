class AddIndexToDevicesOnSerialNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :devices, :serial_number
  end
end
