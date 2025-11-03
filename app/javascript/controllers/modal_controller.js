import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["addContainer", "editContainer"]

  connect() {
    console.log("Modal controller connected")
  }

  // ✅ Add modal
  addModal() {
    this.addContainerTarget.classList.remove("hidden")
  }

  // ✅ Edit modal
  editModal(event) {
    console.log("Edit modal opened for ID:", event.currentTarget.dataset.id)
    this.editContainerTarget.classList.remove("hidden")

    // Get values from data attributes
    let schemeName = event.currentTarget.dataset.schemeName
    let schemeType = event.currentTarget.dataset.schemeType
    let commisionRate = event.currentTarget.dataset.commisionRate
    let schemeId = event.currentTarget.dataset.id

    // Fill edit modal fields
    document.querySelector("#edit_scheme_name").value = schemeName
    document.querySelector("#edit_scheme_type").value = schemeType
    document.querySelector("#edit_commision_rate").value = commisionRate
    document.querySelector("#edit_scheme_id").value = schemeId
  }

  close() {
    this.addContainerTarget.classList.add("hidden")
    this.editContainerTarget.classList.add("hidden")
  }

  backdrop(event) {
    if (event.target === this.addContainerTarget || event.target === this.editContainerTarget) {
      this.close()
    }
  }
}
