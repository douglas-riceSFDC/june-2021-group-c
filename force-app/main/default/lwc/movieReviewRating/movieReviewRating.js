import { LightningElement, api, track } from 'lwc';

export default class MovieReviewRating extends LightningElement {
    @api movieReview;
    @track stars = [];
    @track blankStars = [];

    connectedCallback()
    {
        let totalStars = 5;

        for (let i = 0; i < this.movieReview.Rating__c; i++) {
            this.stars.push({Id: i});
        }

        for (let i = 0; i < totalStars - this.movieReview.Rating__c; i++) {
            this.blankStars.push({Id: i});
        }
    }
}