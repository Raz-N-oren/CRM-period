import { LightningElement,api,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
export default class DataLwc extends LightningElement {

    @api recordId; 
     recordId2; 

    // wire to property
    @wire(getRecord,{recordId: '$recordId2', fields: [NAME_FIELD]})
    account;

     // wire to function
     @wire(getRecord,{recordId: '$recordId', fields: [NAME_FIELD]})  
        accountHandler({error,data}){
            debugger;
            if(data){
                this.recordId2 = this.recordId;
                console.log('data: '+JSON.stringify(data));
            }else if(error){
                console.log('error: '+JSON.stringify(error));
            }
        }

    handleClick(){

        debugger;
        alert('recordId: '+this.recordId);
    //    if(confirm('Are you sure you want to add this Account?')){
    //     alert('true');
    //    }else{
    //     alert('false');
    //     return false;
    //    }
           
    }



    // recordId= '0018e00000J4EeUAAV';
    // objectApiName= 'Account';
    // fields = ['Name', 'Phone', 'Website', 'Industry'];
    // handleSuccess (event) {
    //     const toastEvent = new ShowToastEvent({
    //         title: "Account created",
    //         message: "Record ID: " + event.detail.id,
    //         variant: "success"
    //     });
    //     this.dispatchEvent(toastEvent);
    // }

    // accountPhone = '11111111';
}