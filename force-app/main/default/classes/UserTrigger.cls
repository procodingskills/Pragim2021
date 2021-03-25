/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-14-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-14-2021   i.lakshmideepak@gmail.com   Initial Version
**/
public inherited sharing class UserTrigger {
    List<User> newList ;
    Map<Id,User> newMap;
    Map<Id,User> oldMap;
    
    public void flow(List<User> newList,Map<Id,User> newMap , Map<Id,User> oldMap , System.TriggerOperation eventType){
        this.newList = newList;
        this.newMap= newMap;
        this.oldMap = oldMap;
         switch on eventType {
             
            when AFTER_UPDATE {
                 this.afterUpdate();
            }
            when else{
                return;
            }
         }
         
     }

     // after update operations
     private void afterUpdate(){
        /**
         * Get Contact Ids when there is a Change in First Name or Last Name in User record 
         * Get Related Contacts in Map<Id,Contact> to update based on the Contact Ids retrived from the Trigger Context
         * Perfom DML on COntact Object To update the Latest / Changed First Name and Last Name from User Object
         */
        Map<Id,User> contactIdUsers = new Map<Id,User>();
        for (User record : newMap.values()) {
           User oldRecord = oldMap.get(record.Id);

            Boolean isPartnerUser = record.ContactId != null ? true : false;
            Boolean isFirstNameChanged = record.FirstName != oldRecord.FirstName ? true : false;
            Boolean isLastNameChanged = record.LastName != oldRecord.LastName ? true : false;
            Boolean isValidChange = isFirstNameChanged || isLastNameChanged ? isPartnerUser : false;
            
            if (isValidChange) {
                contactIdUsers.put(record.ContactId,record);
            }
        }

        // Ensure You have Valid Contact Ids
        if(contactIdUsers.keyset().size() > 0){
            Map<Id,Contact> contactMap = new Map<Id,Contact>([SELECT Id , LastName , FirstName FROM Contact WHERE Id IN: contactIdUsers.keyset()]);
            // update the First Name and Last Name based on The user object information 
            for (Contact record : contactMap.values()) {
                User uRecord = contactIdUsers.get(record.Id);
                record.FirstName = uRecord.Firstname;
                record.LastName = uRecord.LastName;
            }

            update contactMap.values();
        }
     }
}
