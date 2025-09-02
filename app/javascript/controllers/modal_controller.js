import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log("Modal controller connected");
  }

  open() {
    this.containerTarget.classList.remove("hidden")
  }

  editModal(event) {
    console.log("Edit modal opened for ID:", event.currentTarget.dataset.id)
    this.open()

    // ✅ Get values from data attributes
    let schemeName = event.currentTarget.dataset.schemeName
    let schemeType = event.currentTarget.dataset.schemeType
    let commisionRate = event.currentTarget.dataset.commisionRate

    // ✅ Fill form fields
    document.querySelector("#scheme_name").value = schemeName
    document.querySelector("#scheme_type").value = schemeType
    document.querySelector("#commision_rate").value = commisionRate

    // (Optional) also update hidden field for ID if needed
    let hiddenId = document.querySelector("#scheme_id")
    if (hiddenId) hiddenId.value = event.currentTarget.dataset.id
  }



  close() {
    this.containerTarget.classList.add("hidden")
  }

  backdrop(event) {
    if (event.target === this.containerTarget) {
      this.close()
    }
  }
}
