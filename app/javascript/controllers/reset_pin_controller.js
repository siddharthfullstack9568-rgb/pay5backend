import { Controller } from "@hotwired/stimulus"

// Handles validation, flash messages, and PIN visibility
export default class extends Controller {
  static targets = ["newPin", "confirmPin", "error", "flash"]

  connect() {
    console.log("Reset PIN page connected ✅");

    // Auto-hide flash message
    if (this.hasFlashTarget) {
      setTimeout(() => {
        this.flashTarget.classList.add("opacity-0", "transition-opacity", "duration-700");
        setTimeout(() => this.flashTarget.remove(), 700);
      }, 3000);
    }
  }

  // ✅ Validate before submit
  validate(event) {
    const newPin = this.newPinTarget.value.trim();
    const confirmPin = this.confirmPinTarget.value.trim();

    if (newPin.length !== 6 || confirmPin.length !== 6) {
      event.preventDefault();
      this.errorTarget.textContent = "PIN must be 6 digits long.";
      return;
    }

    if (newPin !== confirmPin) {
      event.preventDefault();
      this.errorTarget.textContent = "New PIN and Confirm PIN do not match.";
      return;
    }

    this.errorTarget.textContent = "";
  }

  // ✅ Toggle visibility for New PIN
  toggleNewPin() {
    this.toggleVisibility(this.newPinTarget, event.currentTarget);
  }

  // ✅ Toggle visibility for Confirm PIN
  toggleConfirmPin() {
    this.toggleVisibility(this.confirmPinTarget, event.currentTarget);
  }

  // ✅ Shared logic
  toggleVisibility(input, button) {
    const isPassword = input.type === "password";
    input.type = isPassword ? "text" : "password";
    button.textContent = isPassword ? "🙈" : "👁️";
  }
}
