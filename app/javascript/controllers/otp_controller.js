// app/javascript/controllers/otp_controller.js
import { Controller } from "@hotwired/stimulus"

// ✅ OTP Controller
export default class extends Controller {
  static targets = ["digit", "error"]

  connect() {
    console.log('opt js conntectedd');
    this.digitTargets[0]?.focus()
  }

  handleInput(e) {
    const input = e.target
    const value = input.value.replace(/[^0-9]/g, "")
    input.value = value

    if (value && input.nextElementSibling) {
      input.nextElementSibling.focus()
    }
  }

  handleKeyDown(e) {
    const input = e.target

    if (e.key === "Backspace" && !input.value && input.previousElementSibling) {
      input.previousElementSibling.focus()
    }
  }

  handlePaste(e) {
    e.preventDefault()
    const pasted = e.clipboardData.getData("text").replace(/\D/g, "").slice(0, 6)
    const digits = pasted.split("")

    this.digitTargets.forEach((input, i) => {
      input.value = digits[i] || ""
    })
  }

  submit(e) {
    e.preventDefault()
    const otp = this.digitTargets.map((i) => i.value).join("")

    if (otp.length < 6) {
      this.errorTarget.textContent = "Please enter a 6-digit OTP."
      return
    }

    this.errorTarget.textContent = ""
    alert(`✅ OTP Submitted: ${otp}`)
  }
}
