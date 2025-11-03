import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="otp"
export default class extends Controller {
  static targets = ["input", "hiddenOtp", "error"]

  connect() {
    this.inputTargets.forEach((input, index) => {
      // Auto move to next input
      input.addEventListener("input", (e) => this.handleInput(e, index))

      // Move back on Backspace
      input.addEventListener("keydown", (e) => this.handleBackspace(e, index))
    })

    // Handle paste
    this.element
      .querySelector("#otpInputs")
      ?.addEventListener("paste", (e) => this.handlePaste(e))
  }

  handleInput(e, index) {
    const value = e.target.value.replace(/[^0-9]/g, "")
    e.target.value = value
    if (value && index < this.inputTargets.length - 1) {
      this.inputTargets[index + 1].focus()
    }
  }

  handleBackspace(e, index) {
    if (e.key === "Backspace" && !e.target.value && index > 0) {
      this.inputTargets[index - 1].focus()
    }
  }

  handlePaste(e) {
    const pasteData = e.clipboardData.getData("text").trim()
    if (/^\d+$/.test(pasteData)) {
      pasteData.split("").forEach((char, i) => {
        if (this.inputTargets[i]) this.inputTargets[i].value = char
      })
      if (this.inputTargets[pasteData.length - 1]) {
        this.inputTargets[pasteData.length - 1].focus()
      }
    }
    e.preventDefault()
  }

  beforeSubmit(event) {
    const otp = this.inputTargets.map((input) => input.value).join("")
    if (otp.length !== 6) {
      event.preventDefault()
      this.errorTarget.textContent = "Please enter a valid 6-digit OTP."
      return false
    }

    this.errorTarget.textContent = ""
    this.hiddenOtpTarget.value = otp
  }
}
