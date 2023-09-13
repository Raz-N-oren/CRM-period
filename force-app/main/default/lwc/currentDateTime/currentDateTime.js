import { LightningElement } from 'lwc';

export default class CurrentDateTime extends LightningElement {
    get currentDateTime() {
        return new Date().toLocaleString();
    }
}
