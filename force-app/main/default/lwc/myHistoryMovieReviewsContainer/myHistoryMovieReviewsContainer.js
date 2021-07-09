import { LightningElement, track, api } from 'lwc';
import getMovieReviews from '@salesforce/apex/UserHistoryMovieReviewAuraService.getMovieReviews'

export default class MyHistoryMovieReviewsContainer extends LightningElement {
    @track movieReviews;
    @api limit;
    @api recordId;

    connectedCallback() {
        getMovieReviews({ limiter: this.limit, recordId: this.recordId})
            .then(result => {
                this.movieReviews = result;
            })
            .catch(error => {
                console.error('Error occured'. error);
            });
    }
}