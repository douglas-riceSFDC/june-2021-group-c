import { LightningElement, track, api } from 'lwc';
import getRentalsFromCustomer from '@salesforce/apex/RecommendationListAuraService.getRentalsFromCustomer';

export default class MyHistoryMovieRentalsContainer extends LightningElement {
    @track movieRentals;

    connectedCallback(){
        getRentalsFromCustomer()
            .then(result => {
                this.movieRentals = result;
            })
            .catch(error => {
                console.error('Error occurred', error);
            });
    }

}