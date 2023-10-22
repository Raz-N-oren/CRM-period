import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class SearchAccount extends LightningElement {
    searchAccount(event){
        console.log(event.detail.value);
        accountsFromDB;

        if(event?.detail?.value?.length > 1){
            getAccounts({strName: event?.detail?.value}).then(response => {
                console.log("RESPONSE: ", response);
                // this.accountsFromDB = response;
            }).catch(err =>{
                console.log("Error: "+ err?.body?.message);
            })

        }
    }
}