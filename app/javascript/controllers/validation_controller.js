import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validation"
export default class extends Controller {
  static targets = ["input_title", "note_title", "input_message", "note_message", "textarea", "note_song"]

  connect() {
    console.log('hi')
  }

  title() {
    console.log(this.input_titleTarget.value.length)
    if (this.input_titleTarget.value.length > 50) {
      this.note_titleTarget.innerHTML = `max 60 characters`;
    } else if (this.input_titleTarget.value.length <= 50) {
      this.note_titleTarget.innerHTML = ``;
    }
  }

  message() {
    console.log(this.input_messageTarget.value.length)
    if (this.input_messageTarget.value.length > 200) {
      this.note_messageTarget.innerHTML = `max 200 characters`;
    } else if (this.input_messageTarget.value.length <= 200) {
      this.note_messageTarget.innerHTML = ``;
    }
  }

}
