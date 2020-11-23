class DateGetter
  def initialize(schedule_start, schedule_end, date, service_id)
    @schedule_start = DateTime.parse("#{date} #{schedule_start} -0300")
    @schedule_end = DateTime.parse("#{date} #{schedule_end} -0300")
    @service = Service.find(service_id)
  end

  def get_possible_dates
    possible_dates = []
    i = @schedule_start

    while i != @schedule_end do
      possible_dates << {start: i, end: i + @service.duration_in_minutes}
      i = i + 30.minutes
    end

    appointments = Appointment.of_date(@schedule_start)
    result = possible_dates.reject do |date|
      date[:end] > @schedule_end ||
      [1, 2, 0].include?(date[:start].wday) ||
      overlaps_appointments?(appointments, date[:start], date[:end])
    end

    return result
  end

  private

  def overlaps_appointments?(appointments, date_start, date_end)
    appointments.each do |appointment|
      if (appointment.start...appointment.end).overlaps?(date_start...date_end)
        return true
      end
    end

    return false
  end

end