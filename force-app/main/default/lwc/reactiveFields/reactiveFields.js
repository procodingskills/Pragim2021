import { LightningElement } from 'lwc';

export default class Basic extends LightningElement {
     firstName ='';
     lastName ='';
    
    handleChanges(event){
        const field = event.target.name;
        if(field === "firstName"){
            this.firstName = event.target.value;
        }
        else if(field === "lastName"){
            this.lastName = event.target.value;
        }
      }
    get fullName(){
        return (this.firstName +' '+this.lastName).trim().toUpperCase();
    }

    updateName(event){
        const fName = this.template.querySelector("lightning-input[data-my-id=updateFirstName]").value;
        const lName = this.template.querySelector(".lastName").value;
        this.firstName = fName;
        this.lastName = lName;
        this.template.querySelector("lightning-input[data-my-id=firstname]").value = fName;
        this.template.querySelector("lightning-input[data-my-id=lastname]").value = lName;
    }
}
