import { LightningElement , api } from 'lwc';

export default class ChildLwc extends LightningElement {
    @api userName ;

    @api handlerChild(event){
        alert("Child Method Invoked");
        const payLoad = {detail : "Detail Lakshmi"
                        };
        const customEvent = new CustomEvent("childevent" ,payLoad);
        this.dispatchEvent(customEvent);
    }
}