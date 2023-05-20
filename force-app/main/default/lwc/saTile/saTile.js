import { LightningElement, api } from "lwc";

export default class saTile extends LightningElement {
  @api sadetail;

  handleOpenRecordClick() {
    const selectEvent = new CustomEvent("saview", {
      detail: this.sadetail.Id
    });
    this.dispatchEvent(selectEvent);
  }
}