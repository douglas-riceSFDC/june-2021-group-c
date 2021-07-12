import { LightningElement, api, track } from 'lwc';
import getTitleFromId from '@salesforce/apex/UserHistoryMovieReviewAuraService.getTitleFromId'

export default class MyHistoryReviewCard extends LightningElement {
    @api movieReview;
    @track title;

    connectedCallback() {
        console.log(this.movieReview);
        getTitleFromId({titleId: this.movieReview.Title__c})
            .then(result => {
                this.title = result;
                console.log(this.title);
            })
            .catch(error => {
                console.error('Error occurred', error);
            });
    }

}