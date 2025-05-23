import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = { bookedDates: Array }

  connect() {
    const bookedDates = this.bookedDatesValue
      .map(date => new Date(date))
      .sort((a, b) => a - b); // Trier par date croissante

    // Créer des plages entre chaque paire de dates consécutives
    const disabledRanges = [];
    for (let i = 0; i < bookedDates.length - 1; i++) {
      const start = bookedDates[i];
      const end = bookedDates[i + 1];
      disabledRanges.push({
        from: start.toISOString().split('T')[0],
        to: end.toISOString().split('T')[0],
      });
    }


    // Initialiser flatpickr avec les plages désactivées
    flatpickr(this.element.querySelectorAll("input[type='text']"), {

    altInput: true,
    altFormat: "d-m-Y",
    dateFormat: "Y-m-d",

      disable: disabledRanges,
      onDayCreate: (dObj, dStr, fp, dayElem) => {
        const date = new Date(dayElem.dateObj);
        if (bookedDates.some(d => d.getTime() === date.getTime())) {
          dayElem.classList.add("reserved");
        }
      }
    });
  }
}
