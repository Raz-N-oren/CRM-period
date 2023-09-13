import { LightningElement, track } from 'lwc';

export default class AccordionSection extends LightningElement {
    @track inputValue = '';
    @track displayedText = '';

    handleInputChange(event) {
        this.inputValue = event.target.value;
        this.displayedText = this.inputValue;

        // Dispatch a custom event to notify the parent component of the input value change
        const inputChangeEvent = new CustomEvent('inputchange', { detail: this.inputValue });
        this.dispatchEvent(inputChangeEvent);
    }
}
