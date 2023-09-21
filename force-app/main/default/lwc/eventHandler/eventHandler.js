import { LightningElement } from 'lwc';

export default class EventHandler extends LightningElement {
    handleEvent(event) {
        console.log(event);
        // const message = event.detail;
        this.template.querySelector('c-event-handler-child').showToast(event.detail);
        // const childComponent = this.template.querySelector('c-event-handler-child');
        // childComponent.showToast(message);
    }
}
