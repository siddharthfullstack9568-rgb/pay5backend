import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "balance"]

  connect() {
    console.log("Balance Modal controller connected")
  }

  open(event) {
    // get balance from clicked button
    const balance = event.currentTarget.dataset.balance
    console.log("--------------------");
    console.log(balance);

    // set value inside modal
    this.balanceTarget.textContent = balance

    // show modal
    this.containerTarget.classList.remove("hidden")
  }

  close() {
    this.containerTarget.classList.add("hidden")
  }

  backdrop(event) {
    if (event.target === this.containerTarget) {
      this.close()
    }
  }
}
