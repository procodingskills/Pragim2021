/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-06-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   03-06-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AccountLtngController {
    
    @AuraEnabled
    public static List<Account> getAccounts(String accountName){
        try { 
            Integer i = Integer.valueOf(accountName);
            String name = '%'+accountName+'%';
            return [SELECT Id , Name , Rating , Type FROM Account WHERE Name like : name ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}