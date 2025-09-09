import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = { bookings: Array } // [{start: "YYYY-MM-DD", end: "YYYY-MM-DD"}, ...]

  connect() {
    const FRENCH_LOCALE = {
      weekdays: {
        shorthand: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
        longhand: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
      },
      months: {
        shorthand: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jui', 'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'],
        longhand: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
      },
      firstDayOfWeek: 1,
      rangeSeparator: ' au ',
      weekAbbreviation: 'Sem',
      scrollTitle: 'Défiler pour augmenter la valeur',
      toggleTitle: 'Cliquer pour basculer',
    };

    // Construire les plages désactivées à partir des réservations
    const disabledRanges = this.bookingsValue.map(booking => ({
      from: booking.start,
      to: booking.end
    }));

    // Initialiser Flatpickr sur tous les inputs type text du form
    flatpickr(this.element.querySelectorAll("input[type='text']"), {
      minDate: "today",
      altInput: true,
      locale: FRENCH_LOCALE,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      disable: disabledRanges,
      onDayCreate: (dObj, dStr, fp, dayElem) => {
        const date = dayElem.dateObj.toISOString().split('T')[0];
        // Ajouter la classe "reserved" pour le style si la date est dans une réservation
        if (this.bookingsValue.some(b => date >= b.start && date <= b.end)) {
          dayElem.classList.add("reserved");
        }
      }
    });
  }
}
