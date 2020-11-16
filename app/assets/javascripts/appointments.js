// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function renderCalendar() {
    let calendarDiv = document.getElementById('calendar');
    let calendar = new FullCalendar.Calendar(calendarDiv, {
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
            today: "Esta semana",
            prev: "Semana anterior",
            next: "Semana siguiente"
        },
        slotDuration: '01:00',
        slotMinTime: '11:00',
        slotMaxTime: '20:00'
    });
    calendar.render();
}