import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class RentedTitleItem extends NavigationMixin(LightningElement) {
    @api rental;

    connectedCallback() {
        if(new Date(this.rental.Due_Date__c) < new Date()) {
            
        }
    }

    handleRecordNavigation() {
         this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.rental.Stock__r.Title__r.Id,
                objectApiName: 'namespace__ObjectName', // objectApiName is optional
                actionName: 'view'
            }
        });
    }

    get due() {
        return (new Date(this.rental.Due_Date__c) < new Date()) ? 'overdue' : "";
    }
}