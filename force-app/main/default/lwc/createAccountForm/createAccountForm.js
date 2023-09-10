import { LightningElement } from 'lwc';

export default class CreateAccountForm extends LightningElement {

    handleSuccess(event) {
        const accountId = event.detail.id;
        console.log('New Account ID: ' + accountId);
    }
}