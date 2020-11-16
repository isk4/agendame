// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function renderCalendar() {

    fetch("/appointments.json")
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            return Promise.reject(response)
        }
    }).then(data => {
        let calendarDiv = document.getElementById('calendar');
        let calendar = new FullCalendar.Calendar(calendarDiv, {
            events: data,
            locale: 'es',
            initialView: 'timeGridWeek',
            themeSystem: 'bootstrap',
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
            slotMinTime: '11:00',
            slotMaxTime: '20:00'
        });
        
        calendar.render();
        console.log(data);
    }).catch(error => {
        console.log(error.messages);
    })
}