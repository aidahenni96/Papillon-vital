import { Controller } from "@hotwired/stimulus"

// Stimulus controller for toggling long text (e.g. product description)
export default class extends Controller {
  static targets = ["text", "button"]

  connect() {
    this.expanded = false
  }

  toggle() {
    this.expanded = !this.expanded
    this.textTarget.classList.toggle("text-truncated", !this.expanded)
    this.buttonTarget.innerText = this.expanded ? "Voir moins" : "Voir plus"
  }
}