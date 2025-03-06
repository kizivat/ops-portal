import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  static targets = ["alert"];

  dismiss() {
    this.alertTarget.classList.add("opacity-0", "scale-95");
    setTimeout(() => this.alertTarget.remove(), 300);
  }
}
