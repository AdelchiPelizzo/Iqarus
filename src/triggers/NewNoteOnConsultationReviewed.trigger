/**
* Created by Adelchi on 28/12/2017.
*/
trigger NewNoteOnConsultationReviewed on Note (after insert) {
    system.debug('trigger on notes started!');
    String pName = [SELECT Name FROM Profile WHERE Id = :userInfo.getProfileId() LIMIT 1].Name;
    system.debug('pName>>>> '+pName);
    if( pName  == 'Partner Community User - Clone - Doctor' ){
        for(Note n : Trigger.New){
            system.debug(n.ParentId);
            System.debug([SELECT Id, Name FROM Consultation__c WHERE Id =: n.ParentId LIMIT 1].Name);

            if(n.ParentId.getSobjectType() == Schema.Consultation__c.getSObjectType()){
                system.debug(n.ParentId);
                List<Id> consultationsIdsList = new List<Id>();
                Id consultation = [SELECT Id FROM Consultation__c WHERE Id =: n.ParentId LIMIT 1].Id;
                consultationsIdsList.add(consultation);
                SendEmailConsultationStatusReviewed2.sendEmailToMedic(consultationsIdsList);
                SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(consultationsIdsList);
            }
        }
    }
}
