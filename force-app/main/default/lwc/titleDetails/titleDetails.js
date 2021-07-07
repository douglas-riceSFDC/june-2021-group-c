import { LightningElement, track, api} from 'lwc';

import getTitleInformation from '@salesforce/apex/TitleAuraService.getTitleInformation';

export default class TitleDetails extends LightningElement {
    @track title
    @api recordId

    connectedCallback() {
        getTitleInformation({titleId: this.recordId})
            .then(results => {
                this.title = results;
            })
            .catch(error => {
                console.error('Error occured', error);
            });
    }

}