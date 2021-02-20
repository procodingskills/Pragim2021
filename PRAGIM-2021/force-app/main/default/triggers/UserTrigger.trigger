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
trigger UserTrigger on User (after update) {
    new UserTrigger().flow(Trigger.new,Trigger.newMap, Trigger.oldMap, Trigger.operationType);
}