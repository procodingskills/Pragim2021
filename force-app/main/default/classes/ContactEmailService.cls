/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-21-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-21-2021   i.lakshmideepak@gmail.com   Initial Version
**/
global inherited sharing class ContactEmailService implements Messaging.InboundEmailHandler{

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email , Messaging.InboundEnvelope  envelope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String emailBody = email.plainTextBody;
        try{
            Task taskObj = new Task();
            Contact con = [SELECT Id , FirstName , LastName FROM Contact WHERE Email =: email.fromAddress LIMIT 1];
            taskObj.Description =emailBody;
            taskObj.Priority = 'Low';
            taskObj.Subject = email.subject;
            taskObj.IsReminderSet = false;
            taskObj.WhoId = con.Id;
            Insert taskObj;
        result.success = true;
        }
        catch(Exception e){
            result.success = false;
            result.message = e.getMessage();
        }
       
        return result;
    }
   
}