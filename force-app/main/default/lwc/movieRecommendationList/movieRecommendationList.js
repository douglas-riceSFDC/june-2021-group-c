import { LightningElement, track } from 'lwc';
import getRentalsFromCustomer from '@salesforce/apex/recommendationListAuraService.getRentalsFromCustomer';
import getRecommendedTitlesFromGenres from '@salesforce/apex/recommendationListAuraService.getRecommendedTitlesFromGenres';

export default class MovieRecommendationList extends LightningElement {
    @track titles;
    @track genres = [];
    @track rentals;

    connectedCallback() {
    //OUTLINE
        //GET RENTALS FOR CUSTOMER
        getRentalsFromCustomer()
            .then(result => {
                this.rentals = result;
            })
            .catch(error => {
                console.error('Error occured', error);
            });

        //GET GENRES FROM THOSE RENTALS
        for(r in this.rentals) {
            genres.add(r.stock__c.title__c.Genre__c);
        }

        //GET ALL TITLES THAT HAVE THOSE GENRES
        getRecommendedTitlesFromGenres(this.genres)
            .then(result => {
                this.titles = result;
            })
            .catch(error => {
                console.error('Error occured', error);
            });
    }
}