ActiveAdmin.register Appointment do
  index do
    column "Fecha", :start
    column "Nombre del cliente", :client_name
    column "Tipo de servicio", :service_name
    column "Número de teléfono del cliente", :client_phone_number
  end
end