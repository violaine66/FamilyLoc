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
    const FRENCH_LOCALE = {
  weekdays: {
    shorthand: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
    longhand: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
  },
  months: {
    shorthand: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jui', 'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'],
    longhand: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
  },
  firstDayOfWeek: 1, // lundi
  rangeSeparator: ' au ',
  weekAbbreviation: 'Sem',
  scrollTitle: 'Défiler pour augmenter la valeur',
  toggleTitle: 'Cliquer pour basculer',
};



    // Initialiser flatpickr avec les plages désactivées
    flatpickr(this.element.querySelectorAll("input[type='text']"), {
      minDate : "today",
    altInput: true,
    locale: FRENCH_LOCALE,

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
