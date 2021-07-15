import { LightningElement, track, api } from 'lwc';
import getRecommendedTitlesFromUser from '@salesforce/apex/recommendationListAuraService.getRecommendedTitlesFromUser';

export default class MovieRecommendationList extends LightningElement {
    @track titles;
    @api limit = 5;

    connectedCallback() {

        getRecommendedTitlesFromUser({limiter : this.limit})
            .then(result => {
                this.titles = result;
            })
            .catch(error => {
                console.error('Error occured', error);
            });

    }
}