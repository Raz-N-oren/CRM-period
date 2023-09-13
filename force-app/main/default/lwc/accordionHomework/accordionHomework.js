import { LightningElement } from 'lwc';

export default class AccordionHomeWork extends LightningElement {
    inputValueFromSection2 = '';

    openSection1() {
        const accordion = this.template.querySelector('lightning-accordion');
        accordion.activeSectionName = 'Section 1';
    }

    openSection2() {
        const accordion = this.template.querySelector('lightning-accordion');
        accordion.activeSectionName = 'Section 2';
    }

    openSection3() {
        const accordion = this.template.querySelector('lightning-accordion');
        accordion.activeSectionName = 'Section 3';
    }

    handleInputValueChange(event) {
        this.inputValueFromSection2 = event.detail;
    }
}
