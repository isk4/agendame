ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      panel "¡Bienvenido!" do
        
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
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
                td appointment.start.to_s[10..15] + " - " + appointment.end.to_s[10..15]
                td appointment.client_name
                td appointment.service_name
                td appointment.client_phone_number
              end
            end
            
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end

    end

  end
end
