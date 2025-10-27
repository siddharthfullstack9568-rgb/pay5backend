import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step"]

  connect() {
    this.currentStep = 0
    this.stepIndicator = document.getElementById("step-indicator")
    this.showStep(this.currentStep)
  }

  next(event) {
    event.preventDefault()
    if (this.validateStep(this.currentStep)) {
      this.showStep(this.currentStep + 1)
    }
  }

  back(event) {
    event.preventDefault()
    this.showStep(this.currentStep - 1)
  }

  showStep(index) {
    this.stepTargets.forEach((el, i) => {
      el.classList.toggle("hidden", i !== index)
    })
    this.currentStep = index
    if (this.stepIndicator) {
      this.stepIndicator.textContent = index + 1
    }
  }

  validateStep(stepIndex) {
    const step = this.stepTargets[stepIndex]
    const requiredFields = step.querySelectorAll("[required]")
    let valid = true

    requiredFields.forEach((field) => {
      const existingError = field.parentElement.querySelector(".error-message")

      if (field.value.trim() === "") {
        valid = false
        field.classList.add("border-red-500")
        if (!existingError) {
          const error = document.createElement("p")
          error.textContent = "This field is required"
          error.classList.add("error-message", "text-red-500", "text-xs", "mt-1")
          field.parentElement.appendChild(error)
        }
      } else {
        field.classList.remove("border-red-500")
        if (existingError) existingError.remove()
      }
    })

    return valid
  }
}
