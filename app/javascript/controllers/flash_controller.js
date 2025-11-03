import { Controller } from "@hotwired/stimulus"

// Automatically remove flash message after 3 seconds
export default class extends Controller {
  static targets = ["message"]

  connect() {
    if (this.hasMessageTarget) {
      setTimeout(() => {
        this.messageTarget.classList.add("opacity-0", "transition-opacity", "duration-700")
        setTimeout(() => this.messageTarget.remove(), 700) // remove completely after fade-out
      }, 2000)
    }
  }
}
