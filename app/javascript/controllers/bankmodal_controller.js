// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  
  connect() {
    console.log("bank modal connted");
  }


  open() {
    console.log('open funtion is calling');

    this.containerTarget.classList.remove("hidden")
  }

  close() {
    this.containerTarget.classList.add("hidden")
  }

  // ✅ close if click outside modal content
  backdrop(event) {
    if (event.target === this.containerTarget) {
      this.close()
    }
  }
}
