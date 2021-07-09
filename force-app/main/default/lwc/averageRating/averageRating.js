import { LightningElement, track, api } from 'lwc';
import getMovieRatingsInfo from '@salesforce/apex/TitleAuraService.getMovieRatingsInfo';

export default class AverageRating extends LightningElement {
    @track title;
    @api recordId;
    @track stars = [];
    @track blankStars = [];
    @track halfStar = [];
    @track averageRating;

    connectedCallback() {
        getMovieRatingsInfo({recordId: this.recordId})
            .then(result => {
                this.title = result;

                let totalStars = 5;
                this.averageRating = this.title[0].Sum_Review_Ratings__c / this.title[0].Total_Reviews__c;
                
                for (let i = 0; i < Math.floor(this.averageRating / 1); i++) {
                    this.stars.push({Id: i});
                }
                
                for (let i = 0; i < Math.floor((totalStars - this.averageRating) / 1); i++) {
                    this.blankStars.push({Id: i});
                }

                if (this.averageRating % 1 !== 0) {
                    this.halfStar.push({Id: 0});
                }
            })
            .catch(error => {
                console.error('Error occured'. error);
            });
    }
}
