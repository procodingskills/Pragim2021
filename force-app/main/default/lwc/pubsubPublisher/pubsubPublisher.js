import { LightningElement ,wire } from 'lwc';
import {fireEvent} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class PubsubPublisher extends LightningElement {
    
    @wire(CurrentPageReference) pageRef;
    
    pubsubPublish(event){
        let inputValue = this.template.querySelector("lightning-input[data-my-id=inputval]").value;
        let payLoad = {name : inputValue}
        fireEvent(this.pageRef , "pubsubpoc" , payLoad);
    }
}