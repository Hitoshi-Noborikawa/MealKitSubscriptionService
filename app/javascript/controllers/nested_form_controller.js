import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  connect() {
    this.wrapper = this.element.querySelector('.nested-fields-wrapper');
    this.template = this.element.querySelector('#delivery-meal-set-template').innerHTML;
    this.index = this.wrapper.querySelectorAll('.nested-fields').length;
  }

  addField(event) {
    event.preventDefault();
    const html = this.template.replace(/NEW_RECORD/g, this.index);
    this.wrapper.insertAdjacentHTML('beforeend', html);
    this.index++;
  }

  removeField(event) {
    event.preventDefault();
    const field = event.target.closest('.nested-fields');
    if (field) field.remove();
  }
}
