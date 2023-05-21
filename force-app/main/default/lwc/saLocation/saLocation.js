import { LightningElement, api, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

const NAME_FIELD = "SA_details__c.Name__c";
const LOCATION_LATITUDE_FIELD = "SA_details__c.Location__Latitude__s";
const LOCATION_LONGITUDE_FIELD = "SA_details__c.Location__Longitude__s";

const saFields = [
  NAME_FIELD,
  LOCATION_LATITUDE_FIELD,
  LOCATION_LONGITUDE_FIELD
];
export default class saLocation extends LightningElement {
  @api recordId;
  name;
  mapMarkers = []; //array will be stored

  @wire(getRecord, {
    recordId: "$recordId",
    fields: saFields
  })
  loadSA({ error, data }) {
    if (error) {
      console.log(
        "Unexpected error has been occured during getting SA Detail information"
      );
    } else if (data) {
      this.name = getFieldValue(data, NAME_FIELD);
      const Latitude = getFieldValue(data, LOCATION_LATITUDE_FIELD);
      const Longitude = getFieldValue(data, LOCATION_LONGITUDE_FIELD);

      this.mapMarkers = [
        {
          location: { Latitude, Longitude },
          title: this.name,
          description: `Coords: ${Latitude}, ${Longitude}`
        }
      ];
    }
  }
  get cardTitle() {
    return this.name ? `${this.name}'s location` : "Sales Agent location";
  }
}