import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "bankmenu", "rechargemenu"]

  connect() {
    console.log("dropdown connected")
    document.addEventListener("click", this.hide.bind(this)) // outside click listener
  }

  disconnect() {
    document.removeEventListener("click", this.hide.bind(this))
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden") // अब दोबारा click करने पर hide करेगा
  }

  banktoggle(event) {
    event.stopPropagation()
    this.bankmenuTarget.classList.toggle("hidden") // bank dropdown भी toggle करेगा
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      this.bankmenuTarget.classList.add("hidden")
    }
  }

  rechargetoggle(event) {
    event.stopPropagation()
    this.rechargemenuTarget.classList.toggle("hidden") // bank dropdown भी toggle करेगा
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      this.rechargemenuTarget.classList.add("hidden")
    }
  }

}
