// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
const d = document;

function renderCalendar() {

    fetch('/appointments.json')
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            return Promise.reject(response)
        }
    }).then(data => {
        let calendarDiv = d.getElementById('calendar');
        let calendar = new FullCalendar.Calendar(calendarDiv, {
            events: data,
            eventColor: '#ff543e',
            expandRows: true,
            locale: 'es',
            initialView: 'timeGridWeek',
            themeSystem: 'bootstrap',
            hiddenDays: [0, 1, 2],
            allDaySlot: false,
            headerToolbar: {
                left: 'prev',
                center: 'today',
                right: 'next'
            },
            buttonText: {
                today: 'Esta semana',
                prev: 'Semana anterior',
                next: 'Semana siguiente'
            },
            slotDuration: '00:30:00',
            slotLabelInterval: '00:30:00',
            slotLabelFormat: {
                hour: 'numeric',
                minute: '2-digit',
                omitZeroMinute: false,
                meridiem: 'short'
            },
            slotMinTime: '11:00',
            slotMaxTime: '19:00'
        });
        
        calendar.render();
        console.log(data);
    }).catch(error => {
        console.log(error.messages);
    });
}

function getAvailableHours() {
    let button = d.getElementById('get-available-hours');
    button.addEventListener('click', e => {
        e.preventDefault();
        let day = d.getElementById('appointment_date_3i').value;
        let month = d.getElementById('appointment_date_2i').value;
        let year = d.getElementById('appointment_date_1i').value;
        let service_id = d.getElementById('appointment_service_id').value;

        date = `${day}-${month}-${year}`

        fetch(`/appointments/new.json?date=${date}&service_id=${service_id}`)
        .then(response => {
            if (response.ok) {
                return response.json();
            } else {
                Promise.reject(response);
            }
        }).then(data => {
            let select = d.getElementById('appointment_time');
            select.innerHTML = '';
            if (data.length > 0) {
                data.forEach(element => {
                    let option = d.createElement('option');
                    option.value = element;
                    option.textContent = element.slice(11, 16);
                    select.appendChild(option);
                });
            } else {
                let option = d.createElement('option');
                option.value = "";
                option.textContent = "Selecciona una hora";
                option.setAttribute("selected", "true");
                select.appendChild(option);
                alert("¡No existen horarios disponibles para esa fecha y tipo de servicio! Por favor, intenta otra fecha.");
            }
        }).catch(error => {
            console.log(error.messages);
        })


    });
}