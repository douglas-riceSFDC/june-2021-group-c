import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getTitleFromId from '@salesforce/apex/UserHistoryMovieReviewAuraService.getTitleFromId'

export default class MyHistoryReviewCard extends NavigationMixin(LightningElement) {
    @api movieReview;
    @track title;

    connectedCallback() {
        console.log(this.movieReview);
        getTitleFromId({titleId: this.movieReview.Title__c})
            .then(result => {
                if(result){
                    this.title = result[0];
                }
            })
            .catch(error => {
                console.error('Error occurred', error);
            });
    }

    handleTitleSelection() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
				recordId: this.title.Id,
                actionName: 'view',
            }
        });
    }

}