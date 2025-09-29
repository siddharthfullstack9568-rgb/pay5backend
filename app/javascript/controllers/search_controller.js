// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "form"]

  connect() {
    // no timeout needed
  }

  submitOnInput() {
    event.preventDefault();
    this.formTarget.requestSubmit() // form submit immediately
  }
}
