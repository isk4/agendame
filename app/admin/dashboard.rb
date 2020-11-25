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
            
            tr do
              if Appointment.of_date(Date.today).length == 0
                td "No tienes citas para hoy"
              else
                Appointment.of_date(Date.today).map do |appointment|
                  td appointment.start_time + " - " + appointment.end_time
                  td appointment.user.present? ? appointment.client_name : "Cliente borrado"
                  td appointment.service_name
                  td appointment.user.present? ? appointment.client_phone_number : "Cliente borrado"
                end
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
