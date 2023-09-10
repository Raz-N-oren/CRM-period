import { LightningElement } from 'lwc';

export default class MyFirstComponent extends LightningElement {

    // 1. Create a property
    greeting = "World";

    // 2. Create a function
    changeHandler(event){
        this.greeting = event.target.value;
    }

    // 3. Create a getter
    get greetingGetter(){
        return `Hello ${this.greeting.toUpperCase()}`;
    }

    handleClick(){
        debugger;
        alert(`Hello ${this.greeting}`);
    }
}