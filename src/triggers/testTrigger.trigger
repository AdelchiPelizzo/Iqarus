/**
 * Created by Adelchi on 11/01/2018.
 */

trigger testTrigger on Consultation__c (before update) {
    List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
    String MyProfileName = PROFILE[0].Name;
    system.debug('What profile is this ? ---->'+MyProfileName);
    for(Consultation__c newConsultation : Trigger.new){
        Boolean newConsultationIsClosed = newConsultation.status__c.contains('Closed');
        Boolean newConsultationIsLocked = newConsultation.status__c.contains('Locked');
        Consultation__c oldConsultation = Trigger.oldMap.get(newConsultation.Id);
        Boolean oldConsultationIsClosed = oldConsultation.Status__c.contains('Closed');
        Boolean oldConsultationIsLocked = oldConsultation.Status__c.contains('Locked');
        system.debug(MyProfileName+'<---|Partner Community User - Clone|--->'+(MyProfileName+'Partner Community User -  Clone'));
        if(oldConsultationIsLocked){
            system.debug('oldConsultationIsLocked-->'+oldConsultationIsLocked);
            /*
            if(MyProfileName=='System administrator with audit fields'){
                system.debug('Is this a administrator ? ---->'+MyProfileName);
                if(true){ newConsultation.addError('Even if you are an administrator, these Fields are Not editable. Record edit has been limited - Topside supervision!');}
            }else*/ if(MyProfileName=='Partner Community User -  Clone'){
                system.debug('Is this a Partner ? ---->'+MyProfileName);
                /*if(true){ newConsultation.addError('These Fields are Not editable. Record edit has been limited - Topside supervision!');}*/
            }
        }/*
        else if(oldConsultationIsClosed)
        {
            newConsultation.addError('This Record has been Locked because Status is Closed!');
        }*/
    }
}