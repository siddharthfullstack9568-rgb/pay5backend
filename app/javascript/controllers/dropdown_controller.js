// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("conecteddddddddddddddddddddddddd");
    this.open = false
  }

  toggle() {
    this.open = !this.open
    this.menuTarget.classList.toggle("hidden", !this.open)
  }

  close(event) {
    if (this.open && !this.element.contains(event.target)) {
      this.open = false
      this.menuTarget.classList.add("hidden")
    }
  }
}
