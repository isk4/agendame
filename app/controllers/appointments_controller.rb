class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!
  before_action :set_services, only: [:new, :edit]
  before_action :set_available_hours, only: [:new, :edit]

  # GET /appointments
  # GET /appointments.json
  def index
    if params[:date].present?
      date = Date.parse(params[:date])
      @appointments = Appointment.of_date(date)
    else
      #@appointments = Appointment.where(user_id: current_user.id).order(start: :desc)
      @appointments = Appointment.all
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new

    if params[:date].present?

      result = DateGetter.new("11:00", "19:00", params[:date], params[:service_id]).get_possible_dates
      render json: result
    end
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    @appointment.end = @appointment.start + @appointment.duration_in_minutes

    respond_to do |format|
      if @appointment.save

        prueba = AppointmentMailer.with(appointment: @appointment).confirmation.deliver_now

        format.html { redirect_to @appointment, notice: '¡Tu cita fue agendada exitosamente!' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'La cita fue actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'La cita fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_services
      @services = Service.all
    end

    def set_available_hours
      @available_hours = [
        "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00",
        "16:30", "17:00", "17:30", "18:00", "18:30", "19:00"
      ]
    end
    # Only allow a list of trusted parameters through.
    def appointment_params
      p = params.require(:appointment).permit(:date, :time, :service_id)
      date = "#{p["date(3i)"]}-#{p["date(2i)"]}-#{p["date(1i)"]}"
      time = "#{p["time"]} -0300"

      return {
        start: DateTime.parse(date + " " + time),
        service_id: p["service_id"]
      }
    end
end
