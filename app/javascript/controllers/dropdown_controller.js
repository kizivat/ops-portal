import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  connect() {
    this.open = false;
    document.addEventListener("click", this.close.bind(this));
  }

  toggle(event) {
    event.stopPropagation();
    this.open = !this.open;
    this.updateMenu();
  }

  updateMenu() {
    if (this.open) {
      this.menuTarget.classList.remove("invisible", "opacity-0", "scale-95");
      this.menuTarget.classList.add("opacity-100", "scale-100");
    } else {
      this.menuTarget.classList.add("invisible", "opacity-0", "scale-95");
      this.menuTarget.classList.remove("opacity-100", "scale-100");
    }
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.open = false;
      this.updateMenu();
    }
  }
}
