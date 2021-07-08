import { LightningElement, track } from 'lwc';
import getCurrentUsersRentals from '@salesforce/apex/RentalAuraService.getCurrentUsersRentals';

export default class RentedTitlesList extends LightningElement {

    @track rentals;

    connectedCallback() {
        getCurrentUsersRentals()
            .then(result => {
                this.rentals = result;
            })
            .catch(error => {
                console.error('Error occured here', error);
            });
    }
}