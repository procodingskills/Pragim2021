import { LightningElement, wire } from 'lwc';
import { createRecord, getRecord } from 'lightning/uiRecordApi';
const accountFields =['Account.Name'];
export default class CreateAccountRecord extends LightningElement {
    accountName;
    accountRecordId;
    nameChangeHandler(event) {
        this.accountName = event.target.value;
    }

    
    @wire (getRecord , {recordId:'$accountRecordId' , fields:accountFields}) queryAccountData;

    
    createAccountAct() {
        let fields = { 'Name': this.accountName }
        let objectReference = { "apiName": "Account", fields };
        createRecord(objectReference)
            .then(response => {
                this.accountRecordId = response.id;
            }
            )
            .catch(error => {
                alert("Error : " + JSON.stringify(error));
            }
            );
    }

    get queryName(){
        if(this.queryAccountData.data){
            return this.queryAccountData.data.fields.Name.value;
        }
    }
}