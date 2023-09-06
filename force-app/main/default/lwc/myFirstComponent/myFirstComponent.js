import { LightningElement } from 'lwc';

export default class MyFirstComponent extends LightningElement {

    greeting = "Hello";

    get greetingGetter(){
        return this.greeting.toUpperCase();
    }

    handleClick(){
        alert('alert, '+this.greeting);
    }
}