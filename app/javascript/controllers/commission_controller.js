import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="commission"
export default class extends Controller {
  static targets = ["schemeSelect", "schemeHidden", "filterButton"]

  connect() {
    console.log("✅ Commission controller connected")
    this.toggleFilterButton()

    // Reinitialize after Turbo page load
    document.addEventListener("turbo:load", () => {
      this.toggleFilterButton()
      console.log("♻️ Reconnected after Turbo navigation")
    })
  }

 updateScheme(event) {
  const selectedScheme = event.target.value
  this.schemeHiddenTargets.forEach((input) => {
    input.value = selectedScheme
  })

  // enable submit button if something is selected
  const button = this.filterButtonTarget
  if (selectedScheme) {
    button.disabled = false
    button.classList.remove("opacity-50", "cursor-not-allowed")
  } else {
    button.disabled = true
    button.classList.add("opacity-50", "cursor-not-allowed")
  }
}


  applyFilter(event) {
    event.preventDefault()

    const schemeId = this.schemeSelectTarget.value
    const planType = document.getElementById("planType").value

    if (!schemeId) {
      alert("⚠️ Please select a scheme first.")
      return
    }

    const url = `/superadmin/recharge_and_bill_commissions?scheme_id=${schemeId}&plan_type=${planType}`

    // Turbo will refresh and reconnect controller
    Turbo.visit(url)
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
