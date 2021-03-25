/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-23-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-23-2021   i.lakshmideepak@gmail.com   Initial Version
**/
public inherited sharing class AccountInvocable {
    
    @InvocableMethod(label = 'Update Primary Contacts' description ='first invocable method'  category = 'Account')
    public static List<Contact> updatePrimaryContacts(List<Id> accountIds){
        List<Account> accList = [SELECT ID , Primary_Contact__c FROM Account WHERE ID IN: accountIds];
        List<Contact> contacts = new List<Contact>();
        for(Account record : accList){
            Contact con = new Contact();
            con.Id = record.Primary_Contact__c;
            con.FirstName = String.valueOf(system.now());
            contacts.add(con);
        }
        upsert contacts;
        return contacts;
    }
}
