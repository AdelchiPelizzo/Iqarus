/**
 * Created by Adelchi on 28/12/2017.
 */

trigger LockNotes on Note (before update, before delete) {
    sObject consultation = new Consultation__c();
    String ProfileName = [SELECT Name FROM Profile WHERE Id =:userInfo.getProfileId()].Name;
    if(ProfileName == 'Partner Community User - Clone - Doctor'||ProfileName=='Partner Community User -  Clone'){
        if(Trigger.isDelete){
            for(Note n : Trigger.Old){
                if(n.ParentId.getSObjectType() == Consultation__c.sObjectType){
                    n.addError('Record Locked! Once created, Notes cannot be Modified or Delete');
                }
            }
        }
        if(Trigger.isUpdate){
                for(Note n : Trigger.New){
                    if(n.ParentId.getSObjectType() == Consultation__c.sObjectType){
                        n.addError('Record Locked! Once created, Notes cannot be Modified or Delete');
                    }
                }
        }
    }
}