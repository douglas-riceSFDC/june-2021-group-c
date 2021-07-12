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
            })
            .catch(error => {
                console.error('Error occured', error);
            });
    }
}
