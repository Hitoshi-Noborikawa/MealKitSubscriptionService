import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  connect() {
    this.wrapper = this.element.querySelector('.nested-fields-wrapper');
    this.template = this.element.querySelector('#delivery-meal-set-template').innerHTML;
    this.index = this.wrapper.querySelectorAll('.nested-fields').length;

    // form submit時にNEW_RECORD行を除去
    const form = this.element.closest('form');
    if (form) {
      form.addEventListener('submit', this.removeNewRecordFields.bind(this));
    }
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

  // ★追加：NEW_RECORD行を除去
  removeNewRecordFields(event) {
    const newRecordFields = this.wrapper.querySelectorAll('[name*="NEW_RECORD"]');
    newRecordFields.forEach(input => {
      const field = input.closest('.nested-fields');
      if (field) field.remove();
    });
  }
}
