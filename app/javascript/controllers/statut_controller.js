import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="statut"
export default class extends Controller {
  static targets = ["form"]
  connect() {
  }

  async submit(event) {
    event.preventDefault()

    const form = event.target
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: "PATCH",
        headers: {
          Accept: "application/json"
        },
        body: formData
      })

      if (response.ok) {
        const data = await response.json()

        // Récupère le contrôleur `datepicker`
        const datepickerElement = document.querySelector("[data-controller='datepicker']")
        const datepickerController = this.application.getControllerForElementAndIdentifier(
          datepickerElement,
          "datepicker"
        )

        if (datepickerController && typeof datepickerController.updateBookedDates === "function") {
          datepickerController.updateBookedDates(data.booked_dates)
        }

        alert("Statut mis à jour et calendrier synchronisé.")
      } else {
        alert("Erreur lors de la mise à jour du statut.")
      }
    } catch (error) {
      console.error("Erreur réseau :", error)
      alert("Erreur de connexion.")
    }
  }

}
