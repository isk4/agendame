class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service

  def service_name
    self.service.name
  end

  def duration_in_minutes
    self.service.duration.minutes
  end
end
