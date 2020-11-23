class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service
  before_save :set_end
  before_update :set_end

  scope :of_date,             -> (date) { where(start: date.all_day).order(start: :desc) }
  scope :from_user,           -> (user_id) { where(user_id: user_id) }
  scope :future_appointments, -> { where('start >= ?', Date.today.beginning_of_day).order(start: :desc) }
  scope :past_appointments,   -> { where('start < ?', Date.today.beginning_of_day).order(start: :desc) }

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

  def formatted_date
    self.start.strftime('%d-%m-%Y')
  end

  def start_time
    self.start.to_s[10..15]
  end

  def end_time
    self.end.to_s[10..15]
  end

  private

  def set_end
    self.end = self.start + self.duration_in_minutes
  end
end
