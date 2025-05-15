import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2";

// Connects to data-controller="alert"
export default class extends Controller {
  static values = {
    icon: String,
    alertType: String,
    alertHtml: String,
    alertTitle: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String,
  };

  connect() {
    console.log("Alert controller connected");
  }

   initSweetalert(event) {
  event.preventDefault(); // Stop le submit

  Swal.fire({
    icon: this.iconValue,
    title: this.alertTitleValue,
    html: this.alertHtmlValue,
    confirmButtonText: this.confirmButtonTextValue,
    showCancelButton: this.showCancelButtonValue,
    cancelButtonText: this.cancelButtonTextValue,
    reverseButtons: true,
  }).then((result) => {
    if (result.isConfirmed) {
      const form = event.target;

      // On envoie manuellement le formulaire avec fetch
      fetch(form.action, {
        method: form.method,
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams(new FormData(form))
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          Swal.fire({
            icon: "success",
            title: "Succès",
            text: data.message
          });
        } else {
          Swal.fire({
            icon: "error",
            title: "Erreur",
            text: data.errors.join(", ")
          });
        }
      })
      .catch(error => {
        Swal.fire({
          icon: "error",
          title: "Erreur réseau",
          text: "Impossible de mettre à jour la réservation."
        });
        console.error(error);
      });
    }
  });
  }
}
