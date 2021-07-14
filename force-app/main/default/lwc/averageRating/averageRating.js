import { LightningElement, track, api } from 'lwc';
import getMovieRatingsInfo from '@salesforce/apex/TitleAuraService.getMovieRatingsInfo';

export default class AverageRating extends LightningElement {
    @track title;
    @api recordId;
    @track stars = [];
    @track blankStars = [];
    @track halfStar = false;
    @track averageRating;
    @track totalStars = 5;
    @api smallStars;
    ratingFloatDirection;
    starPoints;
    starWidth;
    halfStarWidth;
    starHeight;

    connectedCallback() {
        getMovieRatingsInfo({recordId: this.recordId})
            .then(result => {
                this.title = result;

                this.averageRating = this.title[0].Sum_Review_Ratings__c / this.title[0].Total_Reviews__c;
                
                for (let i = 0; i < Math.floor(this.averageRating / 1); i++) {
                    this.stars.push({Id: i});
                }
                
                for (let i = 0; i < Math.floor((this.totalStars - this.averageRating) / 1); i++) {
                    this.blankStars.push({Id: i});
                }

                if (this.averageRating % 1 !== 0 && (this.stars.length + this.blankStars.length) !== 0) {
                    this.halfStar = true;
                }
                
                this.ratingFloatDirection = this.smallStars ? 'slds-float_left' : 'slds-float_right slds-var-p-right_small';
                this.starPoints = this.smallStars ?  "7.2,1.2 3,15 13.8,6 1.2,6 12,15" : "12,2 5,25 23,10 2,10 20,25";
                this.starWidth = this.smallStars ? "13" : "27";
                this.halfStarWidth = this.smallStars ? "8" : "13";
                this.starHeight = this.smallStars ? "20" : "25";
            })
            .catch(error => {
                console.error('Error occured', error);
            });
    }
}
