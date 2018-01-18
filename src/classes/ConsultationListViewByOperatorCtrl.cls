/**
 * Created by Adelchi on 29/12/2017.
 */

public with sharing class ConsultationListViewByOperatorCtrl {
/*    @AuraEnabled
    public static List<Consultation__c> ConsultationListViewByOperator(){
        List<Consultation__c> consultList = new List<Consultation__c>();
        system.debug('hello world!');
        String userId = userInfo.getUserId();
        system.debug(userId+'userId' );
        String userContact = [SELECT ContactId FROM User WHERE Id =:userId LIMIT 1].ContactId;
        system.debug(userContact + 'userContactId');
        String operator = [SELECT Contract_Employer__c FROM Contact WHERE Id =: userContact].Contract_Employer__c;
        system.debug(operator +'operatorId');
        consultList = [SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c FROM Consultation__c WHERE Operator__c =:operator LIMIT 50];
        system.debug(consultList + 'consultation record list');
        return consultList;
    }*/

    @AuraEnabled
    public static List<Consultation__c> searchForConsultationsBySite(String searchText) {
        List<Consultation__c> consultationList = new List<Consultation__c>();
        system.debug('hello world!');
        String userId = userInfo.getUserId();
        system.debug(userId+'userId' );
        String userContact = [SELECT ContactId FROM User WHERE Id =:userId LIMIT 1].ContactId;
        system.debug(userContact + 'userContactId');
        Contact cnt = [SELECT Contract_Employer__r.Name FROM Contact WHERE Id =: userContact LIMIT 1];
        String operatorName = cnt.Contract_Employer__r.Name;
        consultationList = [SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Operator__r.Name =:operatorName LIMIT 50];
        String query = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchText + '%\' AND Operator__r.Name = \''+operatorName+ '\' ORDER by Site__r.Name ASC LIMIT 10 ';
        if(searchText!=NULL){
            consultationList = Database.query(query);
            system.debug(consultationList);
            return consultationList;

        }
        else{
            system.debug(consultationList);
            return consultationList;

        }
    }

}