import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getTitleFromRental from '@salesforce/apex/recommendationListAuraService.getTitleFromRental';

export default class MyHistoryRentalListLine extends NavigationMixin(LightningElement) {
    @api movieRental;
    @track movie;

    connectedCallback() {
        getTitleFromRental({rental: this.movieRental})
            .then(result => {
                if(result){
                    this.movie = result[0];                    
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
				recordId: this.movie.Id,
                actionName: 'view',
            }
        });
    }
}