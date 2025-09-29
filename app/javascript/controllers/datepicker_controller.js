import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = { bookings: Array } // [{start: "YYYY-MM-DD", end: "YYYY-MM-DD"}, ...]

  connect() {
    const FRENCH_LOCALE = {
      weekdays: {
        shorthand: ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"],
        longhand: ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"],
      },
      months: {
        shorthand: ["Jan", "Fév", "Mar", "Avr", "Mai", "Jui", "Juil", "Aoû", "Sep", "Oct", "Nov", "Déc"],
        longhand: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"],
      },
      firstDayOfWeek: 1,
      rangeSeparator: " au ",
      weekAbbreviation: "Sem",
      scrollTitle: "Défiler pour augmenter la valeur",
      toggleTitle: "Cliquer pour basculer",
    }

    // Construire les plages désactivées
    const disabledRanges = this.bookingsValue.map(booking => ({
      from: booking.start,
      to: booking.end
    }))

    // Récupération des inputs
    const startInput = this.element.querySelector("input[name*='date_debut']")
    const endInput = this.element.querySelector("input[name*='date_fin']")

    // Flatpickr sur date_debut
    const startCalendar = flatpickr(startInput, {
      minDate: "today",
      altInput: true,
      locale: FRENCH_LOCALE,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      disable: disabledRanges,
      onDayCreate: (dObj, dStr, fp, dayElem) => {
        const date = dayElem.dateObj.toISOString().split("T")[0]
        if (this.bookingsValue.some(b => date >= b.start && date <= b.end)) {
          dayElem.classList.add("reserved")
        }
      },
      onChange: (selectedDates) => {
        if (selectedDates.length > 0) {
          const startDate = selectedDates[0]
          endCalendar.set("minDate", startDate)   // empêche de choisir avant
          endCalendar.jumpToDate(startDate)       // ouvre directement sur cette date
        }
      }
    })

    // Flatpickr sur date_fin
    const endCalendar = flatpickr(endInput, {
      minDate: "today",
      altInput: true,
      locale: FRENCH_LOCALE,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      disable: disabledRanges,
      onDayCreate: (dObj, dStr, fp, dayElem) => {
        const date = dayElem.dateObj.toISOString().split("T")[0]
        if (this.bookingsValue.some(b => date >= b.start && date <= b.end)) {
          dayElem.classList.add("reserved")
        }
      }
    })
  }
}
