import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  get form() {
    return this.element.closest("form");
  }

  reset() {
    const form = this.form;

    form.reset();

    const input = form.querySelector("input, textarea");
    input?.focus();
  }

  keydown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      this.submit();
    }
  }

  submit(event) {
    event?.preventDefault();
    this.form.requestSubmit();
  }
}
