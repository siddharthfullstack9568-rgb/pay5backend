// app/javascript/controllers/commission_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["schemeSelect", "schemeHidden", "filterButton"]

  connect() {
    console.log("commission controller calling");
    // Disable submit until scheme selected
    this.toggleFilterButton()
  }

  updateScheme(event) {
    const schemeId = event.target.value

    // Set all hidden fields (inside each form)
    this.schemeHiddenTargets.forEach(input => {
      input.value = schemeId
    })

    // Enable or disable the submit button
    this.toggleFilterButton()
  }

  toggleFilterButton() {
    const schemeId = this.schemeSelectTarget.value
    const button = this.filterButtonTarget

    if (schemeId) {
      button.disabled = false
      button.classList.remove("cursor-not-allowed", "opacity-50")
    } else {
      button.disabled = true
      button.classList.add("cursor-not-allowed", "opacity-50")
    }
  }
}
