import { LightningElement } from 'lwc';

export default class ParentLwc extends LightningElement {
    handleClick(event){
        //c-child-lwc
        this.template.querySelector("c-child-lwc").handlerChild(event);
    }
    eventHandle(event){
        const data = event.detail;
        alert("DATA : "+JSON.stringify(data));
    }
}