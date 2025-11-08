import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["info", "hiddenField"]

  update(event) {
    const opt = event.target.selectedOptions[0]
    if (!opt || !opt.dataset.accountNumber) {
      this.infoTarget.innerHTML = ""
      this.hiddenFieldTarget.value = ""  // clear hidden field
      return
    }

    const acc = opt.dataset.accountNumber
    const ifsc = opt.dataset.ifsc

    // ✅ Show selected bank info
    this.infoTarget.innerHTML = `
      <h2 class="font-semibold mt-2 text-green-600">Account Number: ${acc}</h2>
      <p class="font-semibold mt-2 text-green-600">IFSC: ${ifsc}</p>
    `

    // ✅ Store account number in hidden field (for form submission)
    this.hiddenFieldTarget.value = acc
  }
}
