import { LightningElement, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import generateRentalForMovie from '@salesforce/apex/MovieRentalGenerator.generateRentalForMovie';
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
                console.error('Error occurred', error);
            });
    }

    handleClick() {
        this.buttonTrue = true;

        try{
            generateRentalForMovie({movieId: this.recordId});
            const event = new ShowToastEvent({
                title: 'Rented Movie',
                message: 'Successfully rented movie. Thank you for your business!',
            });
            this.dispatchEvent(event);
        }
        catch(error){
            console.error('Error occurred', error);
        }
        // generateRentalForMovie({movieId: this.recordId});
        //     .then(results => {
        //         const event = new ShowToastEvent({
        //             title: 'Rented Movie',
        //             message: 'Successfully rented movie. Thank you for your business!',
        //         });
        //         this.dispatchEvent(event);
        //     })
        //     .catch(error => {
        //         console.error('Error occurred', error);
        //     });
    }

}