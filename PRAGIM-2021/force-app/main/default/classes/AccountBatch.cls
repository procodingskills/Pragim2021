/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-20-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-20-2021   i.lakshmideepak@gmail.com   Initial Version
 * 1.0   02-20-2021   i.lakshmideepak@gmail.com   Need to Inc,,ude Statefull so that I can hold the size of Data
**/
 global class AccountBatch implements Database.Batchable<sObject> { 
   
      /*
        1) Need to implement Database.Batchable<sObject>
        2) You need to provide method definition for Start 
            1) Database.QueryLocator
            2) Iterable<sObject>
        3) Execute method you batch will be Processed as Chunks --> Database.BatchableContext & List<Sobjects>
        4) Finish method will execute only once in every batch class --> Database.BatchableContext
      */

      global Database.QueryLocator start(Database.BatchableContext bc){
          system.debug('Start Method Executed');
          String query = 'SELECT ID , Name , Description , Type , Rating FROM Account';
        return Database.getQueryLocator(query);
      }

      global void execute(Database.BatchableContext bc , List<Account> chunks){
            // Descritption field with --> AccName - Type - Rating
            for(Account record : chunks){
                    record.Description = record.Name +' - '+record.type + ' - '+record.rating;
            }
            update chunks;
            system.debug('Execute Method Started');
      }

      global void finish(Database.BatchableContext bc){
          AsyncApexJob data = [SELECT Id, CreatedDate, CreatedById, JobType, ApexClassId, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors, CompletedDate, MethodName, ExtendedStatus, 
                                        ParentJobId, LastProcessed, LastProcessedOffset FROM AsyncApexJob WHERE Id =: bc.getJobId() ];
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            List<String> toAddress = new List<String>();
            toAddress.add('i.lakshmideepak@gmail.com');

            // actual email Message implementation
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);
            mail.setReplyTo('DoNotReply@noreply.com');
            mail.setSenderDisplayName('Salesforce CFO');
            mail.setSubject('Account Batch Complete Report');
            String body = '';
            body += '<table>';
            body += '<tr>';
            body += '<th>JobType</th>';
            body += '<th>ApexClassId</th>';
            body += '<th>Status</th>';
            body += '<th>JobItemsProcessed</th>';
            body += '<th>TotalJobItems</th>';
            body += '<th>NumberOfErrors</th>';
            body += '</tr>';
            body += '<tr>';
            body += '<td>'+data.JobType+'</td>';
            body += '<td>'+data.ApexClassId+'</td>';
            body += '<td>'+data.Status+'</td>';
            body += '<td>'+data.JobItemsProcessed+'</td>';
            body += '<td>'+data.TotalJobItems+'</td>';
            body += '<td>'+data.NumberOfErrors+'</td>';
            body += '</tr>';
            body += '</table>';
            body +='<br/> Regards,<br/>I.Lakshmi Deepak';
            mail.setHtmlBody(body);
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('AccountBatch Report on '+system.now()+'.csv');
            attachment.setBody(Blob.valueOf(body));
            List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
            attachments.add(attachment);
            mail.setFileAttachments(attachments);
            emails.add(mail);
            Messaging.sendEmail(emails);
      }
   }

