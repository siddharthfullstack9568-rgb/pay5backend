import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password"
export default class extends Controller {
  static targets = [
    "oldPassword", "password", "confirmPassword", "submitButton",
    "ruleLength", "ruleUppercase", "ruleLowercase",
    "ruleNumber", "ruleSpecial", "ruleMatch"
  ]

  connect() {
    console.log("password controller created");
    // Call lucide only if available (from CDN)
    if (window.lucide) {
      window.lucide.createIcons()
    }
  }

  toggle(event) {
    const button = event.currentTarget
    const inputId = button.dataset.targetId
    const input = this[`${inputId}Target`]
    const icon = button.querySelector("i")

    if (input.type === "password") {
      input.type = "text"
      icon.setAttribute("data-lucide", "eye-off")
    } else {
      input.type = "password"
      icon.setAttribute("data-lucide", "eye")
    }

    if (window.lucide) {
      window.lucide.createIcons()
    }
  }

  validate() {
    const password = this.passwordTarget.value
    const confirm = this.confirmPasswordTarget.value

    const rules = {
      length: password.length >= 8,
      uppercase: /[A-Z]/.test(password),
      lowercase: /[a-z]/.test(password),
      number: /[0-9]/.test(password),
      special: /[@$!%*?&#]/.test(password),
      match: password === confirm && password !== ""
    }

    this.#updateRule(this.ruleLengthTarget, rules.length)
    this.#updateRule(this.ruleUppercaseTarget, rules.uppercase)
    this.#updateRule(this.ruleLowercaseTarget, rules.lowercase)
    this.#updateRule(this.ruleNumberTarget, rules.number)
    this.#updateRule(this.ruleSpecialTarget, rules.special)
    this.#updateRule(this.ruleMatchTarget, rules.match)

    const allValid = Object.values(rules).every(Boolean)
    this.#toggleSubmit(allValid)
  }

  checkOldPassword(event) {
    const oldPass = this.oldPasswordTarget.value
    const newPass = this.passwordTarget.value

    if (oldPass === newPass) {
      event.preventDefault()
      alert("❌ New Password cannot be same as Old Password.")
    }
  }

  #updateRule(element, valid) {
    element.classList.toggle("text-green-600", valid)
    element.classList.toggle("text-red-600", !valid)
  }

  #toggleSubmit(enabled) {
    if (enabled) {
      this.submitButtonTarget.disabled = false
      this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed")
      this.submitButtonTarget.classList.add("bg-indigo-600", "hover:bg-indigo-700")
    } else {
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed")
      this.submitButtonTarget.classList.remove("bg-indigo-600", "hover:bg-indigo-700")
    }
  }
}
