import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-show"
export default class extends Controller {
  connect() {
    console.log('hi')
  }
}
