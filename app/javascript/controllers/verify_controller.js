// app/javascript/controllers/verify_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "transactionId", "pinInputs"];

  connect() {
    // nothing needed here yet
  }

  // Open modal and set transaction ID
  open(event) {
    const button = event.currentTarget;
    const id = button.dataset.id;

    this.transactionIdTarget.value = id;
    this.containerTarget.classList.remove("hidden");

    // Focus the first PIN input
    this.pinInputsTargets[0].focus();
  }

  // Close modal
  close() {
    this.containerTarget.classList.add("hidden");
    this.clearPinInputs();
  }

  // Close modal if clicking backdrop
  backdrop(event) {
    if (event.target === this.containerTarget) {
      this.close();
    }
  }

  // Handle PIN input auto-focus and backspace
  pinInput(event) {
    const inputs = this.pinInputsTargets;
    const index = inputs.indexOf(event.target);

    if (event.inputType === "insertText" && event.target.value.length === 1) {
      // Move to next input
      if (index < inputs.length - 1) {
        inputs[index + 1].focus();
      }
    } else if (event.inputType === "deleteContentBackward") {
      // Move to previous input
      if (index > 0 && !event.target.value) {
        inputs[index - 1].focus();
      }
    }
  }

  // Clear PIN inputs when modal closes
  clearPinInputs() {
    this.pinInputsTargets.forEach(input => input.value = "");
  }
}
