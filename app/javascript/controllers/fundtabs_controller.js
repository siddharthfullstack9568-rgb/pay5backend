// app/javascript/controllers/fundtabs_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fundtabs"
export default class extends Controller {
  static targets = ["button", "content"]

  connect() {
    // Activate first tab by default
    if (this.buttonTargets.length > 0) {
      this.showTab(this.buttonTargets[0])
    }
  }

  switch(event) {
    const button = event.currentTarget
    this.showTab(button)
  }

  showTab(activeButton) {
    const targetId = activeButton.dataset.tab

    // Reset all buttons
    this.buttonTargets.forEach((btn) => {
      btn.classList.remove("text-indigo-600", "border-indigo-600", "border-b-4")
      btn.classList.add("text-gray-500")
    })

    // Hide all tab contents
    this.contentTargets.forEach((content) => content.classList.add("hidden"))

    // Activate selected tab
    activeButton.classList.add("text-indigo-600", "border-indigo-600", "border-b-4")
    activeButton.classList.remove("text-gray-500")

    // Show related tab content
    const selectedContent = this.contentTargets.find((el) => el.id === targetId)
    if (selectedContent) selectedContent.classList.remove("hidden")
  }
}
