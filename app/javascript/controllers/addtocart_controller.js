import { Controller } from "stimulus"
import magicRails from '@rails/ujs'


export default class extends Controller {
  static targets = [ "amount"]
  static values = { number: Number }
 
  connect() {
    this.numberValueChanged()
  }

  plusbtn(e) {
    this.numberValue++
  }

  minusbtn(e) {
    if (this.amountTarget.value >= 2) {
      this.numberValue--;
    }
  }

  changequantity(e) {
    this.numberValue = Number(this.amountTarget.value)
  }

  numberValueChanged() {
    if (this.numberValue !== NaN || this.numberValue != '') {
      this.amountTarget.value = this.numberValue
    }
  }

  add_item(e) {
    const id = this.data.get('id');
    const additemController = document.querySelector('.content')
    const amount = { amount: this.amountTarget.value }
    magicRails.ajax({
      url:  `/carts/add_item/${id}`,
      type: 'post',
      contentType: 'application/json', // 指定傳送到 server 的資料類型
      data: JSON.stringify(amount),
      success: (resp) => {
        console.log(resp, this.amountTarget.value);
      },
      error: (err) => {
        console.log(err);
      }
    })
  }
}
