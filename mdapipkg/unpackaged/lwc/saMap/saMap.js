import { LightningElement, wire } from "lwc";
import {
  subscribe,
  unsubscribe,
  MessageContext
} from "lightning/messageService";
import SA_LIST_UPDATE_MESSAGE from "@salesforce/messageChannel/SAListUpdate__c";
export default class SaMap extends LightningElement {
  mapMarkers = [];
  subscription = null;

  @wire(MessageContext) messageContext;

  connectedCallback() {
    this.subscription = subscribe(
      this.messageContext,
      SA_LIST_UPDATE_MESSAGE,
      (message) => {
        this.handlesAListUpdate(message);
      }
    );
  }
  disconnectedCallback() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }
  handlesAListUpdate(message) {
    this.mapMarkers = message.sadetails.map((sadetail) => {
      const Latitude = sadetail.Location__Latitude__s;
      const Longitude = sadetail.Location__Longitude__s;
      return {
        location: { Latitude, Longitude },
        title: sadetail.Name__c,
        description: `Coords: ${Latitude}, ${Longitude}`,
        icon: "standard:people"
      };
    });
  }
}