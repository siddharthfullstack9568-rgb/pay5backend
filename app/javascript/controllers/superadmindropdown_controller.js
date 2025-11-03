import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="superadmindropdown"
export default class extends Controller {
  static targets = [
    "menu", "bankmenu", "rechargemenu",
    "payment", "account", "collectmoney", "admin"
  ]

  connect() {
    // store a single bound function so we can remove it later
    this.boundDocumentClick = this._onDocumentClick.bind(this)
    document.addEventListener("click", this.boundDocumentClick)
  }

  disconnect() {
    document.removeEventListener("click", this.boundDocumentClick)
  }

  toggle(event) {
    event.stopPropagation() // prevent document click from firing
    const menuName = event.currentTarget.dataset.menu
    if (!menuName) return

    const target = this[`${menuName}Target`]
    if (target) {
      target.classList.toggle("hidden")
    } else {
      console.warn(`superadmindropdown: no target found for '${menuName}'`)
    }
  }

  close(event) {
    if (event) event.stopPropagation()
    const menuName = event?.currentTarget?.dataset?.menu
    if (menuName && this[`${menuName}Target`]) {
      this[`${menuName}Target`].classList.add("hidden")
    }
  }

  // ✅ Now this closes dropdowns only when you click OUTSIDE the controller
  _onDocumentClick(event) {
    // If click is OUTSIDE the controller element → close all menus
    if (!this.element.contains(event.target)) {
      this._hideAll()
    }
  }

  _hideAll() {
    const menuNames = [
      "menu", "bankmenu", "rechargemenu",
      "payment", "account", "collectmoney", "admin"
    ]

    menuNames.forEach((name) => {
      const target = this[`${name}Target`]
      if (target && !target.classList.contains("hidden")) {
        target.classList.add("hidden")
      }
    })
  }
}
