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
public inherited sharing class FutureApex {
   
    @future
    public static void updateRecords(String newMap){
        
        Map<Id,Account> newAccMap = (Map<Id,Account>)JSON.deserialize(newmap, Map<Id,Account>.class);
       for(Account acc : newAccMap.values()){
        acc.Description = 'Future method executed :'+System.now();
       }
       Update newAccMap.values();
    }
}
