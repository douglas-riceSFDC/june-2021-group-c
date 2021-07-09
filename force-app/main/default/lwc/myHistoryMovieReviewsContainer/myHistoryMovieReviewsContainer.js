import { LightningElement, track, api } from 'lwc';
import getUserMovieReviews from '@salesforce/apex/UserHistoryMovieReviewAuraService.getUserMovieReviews'
import Id from '@salesforce/user/Id'

export default class MyHistoryMovieReviewsContainer extends LightningElement {
    @track movieReviews;
    @api limit;
    @api recordId;

    connectedCallback() {
        getUserMovieReviews({recordId: Id})
            .then(result => {
                this.movieReviews = result;
            })
            .catch(error => {
                console.error('Error occured'. error);
            });
    }
}