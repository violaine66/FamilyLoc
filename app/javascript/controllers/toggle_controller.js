import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement"]

  connect() {
    // Optionnel : log pour tester si le contrôleur est bien connecté
    console.log("Toggle controller connected");
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}
