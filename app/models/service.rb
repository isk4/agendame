class Service < ApplicationRecord
  has_many :appointments

  def duration_in_minutes 
    self.duration.minutes
  end
end
