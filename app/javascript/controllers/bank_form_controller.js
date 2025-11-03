import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bank-form"
export default class extends Controller {
  static targets = [
    "input", "error"
  ]

  connect() {
    console.log("✅ Bank form validation controller connected")
  }

  validateInput(event) {
    const input = event.target
    const errorElement = input.nextElementSibling

    if (input.required && input.value.trim() === "") {
      errorElement.textContent = `${input.placeholder || input.name} is required`
      input.classList.add("border-red-500")
    } else {
      errorElement.textContent = ""
      input.classList.remove("border-red-500")
    }

    // Special check for account number confirmation
    if (input.name === "bank[account_number_confirmation]") {
      const accountNumber = this.element.querySelector("[name='bank[account_number]']")
      if (input.value !== accountNumber.value) {
        errorElement.textContent = "Account numbers do not match"
        input.classList.add("border-red-500")
      }
    }
  }

  checkBeforeSubmit(event) {
    let valid = true

    this.inputTargets.forEach((input) => {
      const errorElement = input.nextElementSibling

      if (input.required && input.value.trim() === "") {
        errorElement.textContent = `${input.placeholder || input.name} is required`
        input.classList.add("border-red-500")
        valid = false
      }

      if (input.name === "bank[account_number_confirmation]") {
        const accountNumber = this.element.querySelector("[name='bank[account_number]']")
        if (input.value !== accountNumber.value) {
          errorElement.textContent = "Account numbers do not match"
          input.classList.add("border-red-500")
          valid = false
        }
      }
    })

    if (!valid) {
      event.preventDefault()
    }
  }
}
