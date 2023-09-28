import { LightningElement } from 'lwc';

export default class EventProducer extends LightningElement {
    handleClick() {
        const event = new CustomEvent('biabi0501!', {
            detail: 'This is a custom event message'
        });
        this.dispatchEvent(event);
    }
}
