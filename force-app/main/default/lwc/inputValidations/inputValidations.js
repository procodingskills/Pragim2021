import { LightningElement } from 'lwc';

export default class InputValidations extends LightningElement {

    submitAction(event){
       const isInputsValid = [...this.template.querySelectorAll('.validValues')]
              .reduce( (validSoFar , inputField) => {
                 inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
              },true
             );
        if(isInputsValid){
                alert("All Fields are valid");
        }
        else{
            alert("Please check the input fields");
        }
    }
}