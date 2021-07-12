import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class TitleCard extends NavigationMixin(LightningElement) {
	@api title;

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
