/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-28-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   03-28-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class sObjectService {
   
    @AuraEnabled(cacheable=true)
    public static string getObjectApiName(String objectLabel){
        try {
            if(objectLabel == 'WireProperty'){
                return 'Wire Property';
            }
            else if(objectLabel == 'WireFunction'){
                Integer k = Integer.valueOf('Parag');
                return 'Wire Function';
            }
            else if(objectLabel == 'Imperative'){
                return 'ON User Action';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return null;
    }
}
