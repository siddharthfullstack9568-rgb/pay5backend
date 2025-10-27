import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-steps"
export default class extends Controller {
  static targets = ["step"]

  connect() {
    this.currentStep = 0
    this.showStep(this.currentStep)
  }

  showStep(index) {
    this.stepTargets.forEach((el, i) => {
      el.classList.toggle("hidden", i !== index)
    })
  }

  next(event) {
    const currentFields = this.stepTargets[this.currentStep].querySelectorAll("[required]")
    let valid = true

    currentFields.forEach((field) => {
      const error = field.nextElementSibling
      if (field.value.trim() === "") {
        valid = false
        field.classList.add("border-red-500", "focus:ring-red-500")
        if (!error || !error.classList.contains("error-msg")) {
          field.insertAdjacentHTML("afterend", `<p class="error-msg text-red-500 text-sm mt-1">This field is required</p>`)
        }
      } else {
        field.classList.remove("border-red-500", "focus:ring-red-500")
        if (error && error.classList.contains("error-msg")) {
          error.remove()
        }
      }
    })

    if (!valid) {
      event.preventDefault()
      return
    }

    this.currentStep++
    if (this.currentStep >= this.stepTargets.length) this.currentStep = this.stepTargets.length - 1
    this.showStep(this.currentStep)
  }

  prev() {
    this.currentStep--
    if (this.currentStep < 0) this.currentStep = 0
    this.showStep(this.currentStep)
  }
}
