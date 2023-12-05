import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "link" ]
  static values = {
    feedbackText: String
  }

  copy(event) {
    event.preventDefault();


    // this.inputTarget.select();
    navigator.clipboard.writeText(event.target.getAttribute('href')).then(() => {
      /* clipboard successfully set */
    }, () => {
      /* clipboard write failed */
    });
    event.currentTarget.disabled = true;
    event.currentTarget.innerText = this.feedbackTextValue;

    this.linkTarget.innerText = "Copied!";
  }
}
