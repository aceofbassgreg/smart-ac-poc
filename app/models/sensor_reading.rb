class SensorReading < ApplicationRecord
  belongs_to :device

  def self.search(search)
    where(device_id: search)
  end
end
