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
    event.preventDefault(); // Prevent the form to be submited after the submit button has been clicked

    Swal.fire({
      icon: this.iconValue,
      title: this.alertTitleValue,
      html: this.htmlValue,
      confirmButtonText: this.confirmButtonTextValue,
      showCancelButton: this.showCancelButtonValue,
      cancelButtonText: this.cancelButtonTextValue,
      reverseButtons: true,
    }).then((action) => {
      if (action.isConfirmed) {
        event.target[event.type](); // "submit"
      }
    })
    .catch(event.preventDefault())
  }
}
