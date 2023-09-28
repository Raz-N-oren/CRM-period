import { LightningElement } from 'lwc';

export default class EventTarget extends LightningElement {
    handleButtonClick(event) {
        const buttonElement = event.target;

        alert('Button clicked!  ---->'+ event.target.innerHTML);

        buttonElement.style.backgroundColor = 'lightblue';
        buttonElement.innerHTML = 'Clicked';
    }

    
}