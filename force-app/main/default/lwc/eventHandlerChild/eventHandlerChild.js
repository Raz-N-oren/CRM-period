// eventHandlerChild.js
import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EventHandlerChild extends LightningElement {
    @api showToast(message) {
        // alert(message);
        const toastEvent = new ShowToastEvent({
            title: 'Custom Event Message',
            message: message,
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
    }
}
