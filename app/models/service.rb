class Service < ApplicationRecord
  def duration_in_minutes 
    self.duration.minutes
  end
end
