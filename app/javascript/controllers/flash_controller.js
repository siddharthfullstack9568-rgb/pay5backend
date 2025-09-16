// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { duration: Number }
  static targets = ["message"]

  connect() {
    this.messageTargets.forEach((el) => {
      // Show animation
      el.classList.add("translate-y-0", "opacity-100");

      // Hide after duration
      setTimeout(() => {
        el.classList.add("opacity-0", "translate-y-[-20px]");
        setTimeout(() => el.remove(), 300); // remove from DOM after transition
      }, this.durationValue || 3000);
    });
  }
}
