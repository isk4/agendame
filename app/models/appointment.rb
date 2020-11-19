class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service

  scope :of_date, -> (date) { where(start: date.all_day) }

  def client_name
    self.user.name
  end

  def service_name
    self.service.name
  end

  def duration_in_minutes
    self.service.duration.minutes
  end

  def client_phone_number
    self.user.phone_number
  end

  def client_email
    self.user.email
  end
end
