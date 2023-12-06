import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spotify-connect"
export default class extends Controller {
  static targets = ["connect", "dashboard"]

  connect() {
    console.log("hi")
  }

  skip() {
    this.connectTarget.classList.add("d-none")
    this.dashboardTarget.classList.remove("d-none")
  }
}
