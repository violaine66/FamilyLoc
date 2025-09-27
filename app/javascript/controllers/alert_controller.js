import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {
  static values = {
    icon: String,
    alertHtml: String,
    alertTitle: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String
  }

  connect() {
    console.log("Alert controller connected")
  }

  initSweetalert(event) {
    event.preventDefault() // stop le submit

    Swal.fire({
      icon: this.iconValue,
      title: this.alertTitleValue,
      html: this.alertHtmlValue,
      confirmButtonText: this.confirmButtonTextValue,
      showCancelButton: this.showCancelButtonValue,
      cancelButtonText: this.cancelButtonTextValue,
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        // Soumission classique HTML, Rails fera le redirect et affichera les flashs
        event.target.submit()
      }
      // Sinon, rien à faire
    })
  }
}
