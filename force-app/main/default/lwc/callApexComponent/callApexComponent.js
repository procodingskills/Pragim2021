import { LightningElement , wire } from 'lwc';
import getObjectApiName from '@salesforce/apex/sObjectService.getObjectApiName';

export default class CallApexComponent extends LightningElement {

    /* 1) Wire a Property 
       2) Wire a Function 
       3) Call a Method Imperatively    
    */
   //1) Wire a Property 
   @wire(getObjectApiName,{ objectLabel : "WireProperty"}) wirePropertyVariable;

   //  2) Wire a Function 
   wireFunctunctionData;
   wireFunctionerror;
   @wire(getObjectApiName,{ objectLabel : "WireFunction"})
    processWireFunction({error,data}){
        if(data){
            this.wireFunctunctionData = data;
        }
        if(error){
            this.wireFunctionerror = error.body.message;
        }
    }
    //  3) Call a Method Imperatively 
    userData;
    userError;
    handleUser(event){
        let params = {objectLabel : "Imperative"};
        getObjectApiName(params)
        .then(result => {
            this.userData = result;
        })
        .catch(erorr => {
            this.error = error;
        });
    }

    connectedCallback(event){
        alert("Conected callback calling from callApexComponent");
        this.handleUser(event);
    }

}