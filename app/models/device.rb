class Device < ApplicationRecord
  has_many :sensor_readings
  
  def self.search(search)
    if search
      results = where(serial_number: search)
      results.empty? ? Device.all : results
    else
      Device.all
    end
  end
end
