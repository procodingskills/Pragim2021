/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-22-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-22-2021   i.lakshmideepak@gmail.com   Initial Version
**/
public inherited sharing class AccountBatchSchedular implements Schedulable{
    public void execute(SchedulableContext sc){
        AccountBatch batchJob = new AccountBatch(); 
        Database.executeBatch(batchJob , 2000);
    }
}


// https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_crontrigger.htm