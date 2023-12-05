import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview"
export default class extends Controller {
  static targets = ["card", "player"]

  connect() {
    console.log('hi')
  }

  start() {
    this.cardTarget.classList.add("d-none")
    this.playerTarget.classList.remove("d-none")
  }
}
