import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class MyHistoryRentalList extends NavigationMixin(LightningElement) {
    @api movieRentals;
    @track rental;


    connectedCallback(){
        
    }

    handleClick(){
        // this[NavigationMixin.Navigate]({
        //     type: 'standard__recordPage',
        //     attributes: {
		// 		recordId: this.rental.Id,
        //         actionName: 'view',
        //     }
        // });
        
    }

}