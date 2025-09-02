// app/javascript/controllers/retailer_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    console.log("Retailer Controller Connected")
  }

  toggle(event) {
    const clickedCheckbox = event.target

    if (clickedCheckbox.checked) {
      this.checkboxTargets.forEach((checkbox) => {
        if (checkbox !== clickedCheckbox) {
          checkbox.disabled = true
        }
      })
    } else {
      this.checkboxTargets.forEach((checkbox) => {
        checkbox.disabled = false
      })
    }
  }
}
