/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-20-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-20-2021   i.lakshmideepak@gmail.com   Initial Version
**/
 global class BatchApexTemplate implements Database.Batchable<sObject>, Database.AllowsCallouts {
   
       global List<Object> start(Database.BatchableContext jobId) {
           List<Object> recordList = new List<Object>();
           recordList = [SELECT fields
                         FROM Object
                         WHERE conditions];
           return recordList;
       }
   
       global void execute(Database.BatchableContext jobId, List<Object> recordList) {
           
       }
   
       global void finish(Database.BatchableContext jobIdParam) {
           list<CronTrigger> ct = [SELECT CronExpression, CronJobDetailId, CronJobDetail.Name, Id, State FROM CronTrigger WHERE CronJobDetail.Name like '%nomeBatch%'];
           list<AsyncApexJob> apJb = [SELECT TotalJobItems,JobItemsProcessed,NumberOfErrors,CreatedDate,CompletedDate,ExtendedStatus
                                      FROM AsyncApexJob where ApexClass.Name = 'nomeBatch'
                                      ORDER BY CompletedDate desc limit 1];
           if(ct.size()>0) {
               System.abortJob(ct[0].id);
           }
           if(apJb.size()>0) {
               if(apJb[0].NumberOfErrors <> 0){
                   Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                   message.toAddresses = new String[] { 'your@email.com'};
                   message.subject = 'Erro no batch nomeBatch';
                   message.plainTextBody = 'Erro no batch nomeBatch: '+apJb[0].TotalJobItems+'\r\n'+ 'Lotes Processados: '+apJb[0].JobItemsProcessed+'\r\n'+ 'Falhas: '+apJb[0].NumberOfErrors+'\r\n'+ 'Data do Envio: '+apJb[0].CreatedDate+'\r\n'+ 'Data de Conclusão: '+apJb[0].CompletedDate+'\r\n'+'Msg de Erro: '+apJb[0].ExtendedStatus;
                   Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                   if(!Test.isRunningTest()){
                       Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                       if (results[0].success) {
                           System.debug('O email foi enviado com sucesso');
                       } else {
                           System.debug('Houve falha no envio do email: ' + results[0].errors[0].message);
                       }
                   }
               }
           }
           if(!Test.isRunningTest()) {
               System.scheduleBatch(new nomeBatch(), 'Job nomeBatch' + system.now().format('dd.MM.yyyy-HH.mm.ss.SSS'),minutesFromNow, batchSize);
           }
       }
   }

