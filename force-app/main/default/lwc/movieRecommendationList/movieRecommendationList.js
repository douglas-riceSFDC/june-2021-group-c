import { LightningElement, track } from 'lwc';
import getRecommendedTitlesFromUser from '@salesforce/apex/recommendationListAuraService.getRecommendedTitlesFromUser';

export default class MovieRecommendationList extends LightningElement {
    @track titles;

    connectedCallback() {

        getRecommendedTitlesFromUser()
            .then(result => {
                this.titles = result;
            })
            .catch(error => {
                console.error('Error occured', error);
            });

    }
}