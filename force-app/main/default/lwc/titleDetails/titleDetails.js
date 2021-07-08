import { LightningElement, api, track} from 'lwc';

import getTitleInformation from '@salesforce/apex/TitleAuraService.getTitleInformation';

export default class TitleDetails extends LightningElement {
    @api titles;
    @api recordId;
    @api limit;
    @track buttonTrue = false;

    connectedCallback() {
        getTitleInformation({recordId: this.recordId})
            .then(results => {
                this.titles = results;
                if(this.titles[0].Available_Stock__c === 0){
                    this.buttonTrue = true;
                }
            })
            .catch(error => {
                console.error('Error occured', error);
            });
    }

    handleClick(event) {
        rentMovie({recordId: this.recordId});
    }

}