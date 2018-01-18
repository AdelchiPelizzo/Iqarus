/**
 * Created by Adelchi on 10/01/2018.
 */

public with sharing class NotificationCtrl {
    @AuraEnabled
    public static Boolean IsClosed(Id recordId){
        List<Consultation__c> consultation  = [SELECT Status__c  FROM Consultation__c WHERE Id =:recordId];
        String status = consultation[0].Status__c;
        if(status == 'Closed' || status == 'Closed with Follow up required'){
            return True;
        }else{
            return False;
        }
    }
    @AuraEnabled
    public static Boolean IsLocked(Id recordId){
        List<Consultation__c> consultation  = [SELECT Status__c  FROM Consultation__c WHERE Id =:recordId];
        String status = consultation[0].Status__c;
        if(status == 'Submitted for Topside supervision Locked'){
            return True;
        }else{
            return False;
        }
    }
}