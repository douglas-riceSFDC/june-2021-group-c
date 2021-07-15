import { LightningElement, api, track} from 'lwc';

export default class MyHistoryReviewList extends LightningElement {
    @api movieReviews;
    @track review;
}
