import { LightningElement, track, api } from 'lwc';
import getCurrentUsersRentals from '@salesforce/apex/RentalAuraService.getCurrentUsersRentals';

export default class RentedTitlesList extends LightningElement {

    @api limit;
    @track rentals;

    connectedCallback() {
        getCurrentUsersRentals({limiter: this.limit})
            .then(result => {
                this.rentals = result;
            })
            .catch(error => {
                console.error('Error occured here', error);
            });
    }
}