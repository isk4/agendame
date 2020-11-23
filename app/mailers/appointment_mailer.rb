class AppointmentMailer < ApplicationMailer
	default from: 'Miriam Dibán <citas@miriamdiban.com>'
	before_action { @appointment = params[:appointment] }

	def confirmation
		@appointment = params[:appointment]
		mail(to: @appointment.client_email, subject: 'Confirmación de cita')
	end
end
