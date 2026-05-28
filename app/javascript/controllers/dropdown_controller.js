import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.closeHandler = this.close.bind(this)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")

    if (!this.menuTarget.classList.contains("hidden")) {
      document.addEventListener("click", this.closeHandler)
    } else {
      document.removeEventListener("click", this.closeHandler)
    }
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      document.removeEventListener("click", this.closeHandler)
    }
  }

  disconnect() {
    document.removeEventListener("click", this.closeHandler)
  }
}
