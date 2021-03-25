/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-20-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   02-07-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger AccountTrigger on Account (before insert , after insert , after update , after delete , after undelete , before update , before delete) {

    /**
     * Before Insert --> Trigger.new
     * Before Update --> Trigger.new , TriggernewMap , Trigger.old , Trigger.oldMap
     * After Insert --> Trigger.new , Trigger.newMap
     * After Update --> Trigger.new , Trigger.newMap , Trigger.old , trigger.oldMap
     * Before Delete --> Trigger. old, Trigger.oldMap
     * After Delete --> Trigger.old , Trigger.oldMap
     * After Undlete --> Trigger.new , Trigger.newMap
     
     * User --> New --> Field Details --> Save --> Commit --> Before triggers --> Saving to Saobject -- > After Triggers --> Transaction Close --> Record Detail Page
     * 
     * Trigger.new , Trigger.old --> List<Account>
     * Trigger.newMap , Trigger.oldMap --> Map< Id , Account> 
     */

     if(Trigger.isBefore && Trigger.isInsert){
        AccountTrigger.beforeInsert(Trigger.new);
     }
     if(Trigger.isAfter && Trigger.isInsert){
         AccountTrigger.afterInsert(Trigger.newMap);
     }
     if(Trigger.isAfter && Trigger.isUpdate){
         
         if(!System.isFuture() && ! system.isBatch()){
            FutureApex.updateRecords(JSON.serialize(Trigger.newMap));
         }
        
     }
}