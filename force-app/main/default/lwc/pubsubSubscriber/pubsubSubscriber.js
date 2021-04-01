import { LightningElement ,wire } from 'lwc';
import { registerListener,
    unregisterListener,
    unregisterAllListeners,
    fireEvent} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class PubsubSubscriber extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        registerListener("pubsubpoc",this.handlePubSub,this);
    }

    handlePubSub(payLoad){
      let name = payLoad.name;
      alert("Pubsub Published and Handled on pubsubSubscriber.js : "+name);
    }

}