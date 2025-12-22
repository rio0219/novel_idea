import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      if (query.length < 2) {
        this.resultsTarget.innerHTML = ""
        return
      }

      fetch(`/posts/autocomplete?q=${encodeURIComponent(query)}`)
        .then(res => res.json())
        .then(data => {
          this.resultsTarget.innerHTML = data
            .map(item => `<div class="autocomplete-item" data-action="click->autocomplete#select">${item}</div>`)
            .join("")
        })
    }, 300)
  }

  select(event) {
    this.inputTarget.value = event.target.textContent
    this.resultsTarget.innerHTML = ""
  }
}
