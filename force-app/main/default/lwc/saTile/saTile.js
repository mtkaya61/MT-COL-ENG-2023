import { LightningElement, api } from "lwc";

export default class saTile extends LightningElement {
  @api sadetail; //public property coming from parent

  handleOpenRecordClick() { //custom event will get Id of SA; by the ID go to the record page
    const selectEvent = new CustomEvent("saview", {
      detail: this.sadetail.Id
    });
    this.dispatchEvent(selectEvent);
  }
}