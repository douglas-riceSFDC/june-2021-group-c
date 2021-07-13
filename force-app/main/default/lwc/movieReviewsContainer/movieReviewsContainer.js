import getMovieReviews from '@salesforce/apex/MovieReviewAuraService.getMovieReviews';
import { LightningElement, track, api } from 'lwc';

export default class MovieReviewsContainer extends LightningElement {
    @track movieReviews;
    @api limit = 5;
    @api recordId;

    connectedCallback() {
        getMovieReviews({ limiter: this.limit, recordId: this.recordId})
            .then(result => {
                this.movieReviews = result;
            })
            .catch(error => {
                console.error('Error occured', error);
            });
    }
}
