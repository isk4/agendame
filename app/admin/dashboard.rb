ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Citas de hoy" do
          table do
            thead do
              th "Hora"
              th "Cliente"
              th "Servicio"
              th "Número de teléfono"
            end
            Appointment.of_date(Date.today).map do |appointment|
              tr do
                td appointment.start_time + " - " + appointment.end_time
                td appointment.client_name
                td appointment.service_name
                td appointment.client_phone_number
              end
            end
          end
        end
      end

      column do
        panel "Totalidad de citas agrupadas por día de la semana" do
          column_chart Appointment.group_by_day_of_week(:start, format: "%a", week_start: :monday).count, xtitle: "Día de la semana", ytitle: "Cantidad de citas"
        end

        panel "Totalidad de citas agrupadas por tipo de servicio" do
          result = Service.all.map do |service|
            [service.name, service.appointments.count]
          end
          pie_chart result
        end
      end
    end
  end
end
