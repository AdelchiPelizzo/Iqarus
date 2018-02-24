/**
 * Created by Adelchi on 29/12/2017.
 */

public with sharing class ConsultationListViewByOperatorCtrl {
    @AuraEnabled
    public static List<String> getPicklistValues()
    {
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Consultation__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(f.getValue());
            /*options.add(new SelectOption(f.getLabel(), f.getValue()));*/
        }
        system.debug(options);
        return options;
    }

    @AuraEnabled
    public static List<Consultation__c> searchForConsultations(String searchSite, String searchStatus, String searchDate) {
        system.debug(searchDate);
        system.debug(searchStatus);
        String searchStat = searchStatus;
        if(searchStatus==''){
            searchStat = NULL;
        }
        Integer intYear;
        Integer intMonth;
        Integer intDay;
        if(searchDate!= null){
            List<String> dateStr = searchDate.split('-');
            List<Integer> dateInt = new List<Integer>();
            intYear = Integer.valueOf(dateStr[0]);
            system.debug(intYear);
            intMonth = Integer.valueOf(dateStr[1]);
            intDay = Integer.valueOf(dateStr[2]);
        }
        List<Consultation__c> consultationList = new List<Consultation__c>();
        system.debug('hello world!');
        String ProfileName = [SELECT Name FROM Profile WHERE Id =:userInfo.getProfileId()].Name;
        String userId = userInfo.getUserId();
        system.debug(userId+'userId' );
        String userContact = [SELECT ContactId FROM User WHERE Id =:userId LIMIT 1].ContactId;
        system.debug(userContact + 'userContactId');
        Contact cnt = [SELECT Contract_Employer__r.Name FROM Contact WHERE Id =: userContact LIMIT 1];
        String operatorName = cnt.Contract_Employer__r.Name;
        if(ProfileName!='Partner Community User - Clone - Doctor'){
            consultationList = [SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Operator__r.Name =:operatorName LIMIT 50];
        }else{
            consultationList = [SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c LIMIT 50];
        }

        String querySite = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite + '%\' ORDER by CreatedDate DESC LIMIT 10 ';
        String querySiteAndStatus = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite +'%\' AND Status__c LIKE \'%'+ searchStat +'%\' ORDER by CreatedDate DESC LIMIT 10 ';
        String querySiteAndStatusAndDate = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite +'%\' AND Status__c LIKE \'%'+ searchStat +'%\' AND DAY_ONLY(CreatedDate) > '+searchDate+ ' ORDER by CreatedDate DESC LIMIT 10 ';
        String queryStatusAndDate = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Status__c = \''+ searchStat +'\' AND DAY_ONLY(CreatedDate) > '+searchDate+  ' ORDER by CreatedDate DESC LIMIT 10 ';
        String querySiteAndDate = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite + '%\' AND DAY_ONLY(CreatedDate) > '+searchDate+' ORDER by CreatedDate DESC LIMIT 10 ';
        String queryDate = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE DAY_ONLY(CreatedDate) > '+searchDate+' ORDER by CreatedDate DESC LIMIT 10 ';
        String queryStatus = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Status__c = \''+ searchStat + '\' ORDER by CreatedDate DESC LIMIT 10 ';

        String querySiteNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite + '%\' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';
        String querySiteAndStatusNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite +'%\' AND Status__c LIKE \'%'+ searchStat +'%\' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';
        String querySiteAndStatusAndDateNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite +'%\' AND Status__c LIKE \'%'+ searchStat +'%\' AND DAY_ONLY(CreatedDate) > '+searchDate+ ' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';
        String queryStatusAndDateNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Status__c = \''+ searchStat +'\' AND DAY_ONLY(CreatedDate) > '+searchDate+  ' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';
        String querySiteAndDateNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Site__r.Name LIKE \'%'+ searchSite + '%\' AND DAY_ONLY(CreatedDate) > '+searchDate+' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';
        String queryDateNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE DAY_ONLY(CreatedDate) > '+searchDate+' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';
        String queryStatusNM = 'SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Status__c = \''+ searchStat + '\' AND Operator__r.Name = \''+operatorName+ '\' ORDER by CreatedDate DESC LIMIT 10 ';

        if(ProfileName!='Partner Community User - Clone - Doctor'){
            consultationList = [SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c WHERE Operator__r.Name =:operatorName LIMIT 50];
            if(searchSite==NULL && searchStat==NULL && searchDate==NULL){
                return consultationList;
            }else if(searchSite!=NULL && searchStat==NULL && searchDate==NULL){
                consultationList = Database.query(querySiteNM);
                system.debug('First IF NM>>> '+consultationList);
                return consultationList;
            }else if(searchSite!=NULL && searchStat!=NULL && searchDate==NULL){
                consultationList = Database.query(querySiteAndStatusNM);
                system.debug('Second IF NM>>> '+consultationList);
                return consultationList;
            }else if(searchSite!=NULL && searchStat!=NULL && searchDate!=NULL){
                consultationList = Database.query(querySiteAndStatusAndDateNM);
                system.debug('Third IF NM>>> '+consultationList);
                return consultationList;
            }else if(searchSite==NULL && searchStat!=NULL && searchDate!=NULL){
                consultationList = Database.query(queryStatusAndDateNM);
                system.debug('Fourth IF NM>>> '+consultationList);
                return consultationList;
            }else if(searchSite!=NULL && searchStat==NULL && searchDate!=NULL){
                consultationList = Database.query(querySiteAndDateNM);
                system.debug('Fifth IF NM>>> '+consultationList);
                return consultationList;
            }else if(searchSite==NULL && searchStat!=NULL && searchDate==NULL){
                consultationList = Database.query(queryStatusNM);
                system.debug('Sixth IF NM>>> '+consultationList);
                return consultationList;
            }else if(searchSite==NULL && searchStat==NULL && searchDate!=NULL){
                system.debug('Seventh IF NM>>> '+queryDate);
                consultationList = Database.query(queryDateNM);
                return consultationList;
            }else{
                system.debug('Last  IF NM>>> '+consultationList);
                return consultationList;
            }
        }else{
            consultationList = [SELECT Id, Name, Client__r.Name, Operator__r.Name, Situation__c, Outcome__c, Status__c, Site__r.Name FROM Consultation__c LIMIT 50];
            if(searchSite==NULL && searchStat==NULL && searchDate==NULL){
                return consultationList;
            }else if(searchSite!=NULL && searchStat==NULL && searchDate==NULL){
                consultationList = Database.query(querySite);
                system.debug('First IF >>> '+consultationList);
                return consultationList;
            }else if(searchSite!=NULL && searchStat!=NULL && searchDate==NULL){
                consultationList = Database.query(querySiteAndStatus);
                system.debug('Second IF >>> '+consultationList);
                return consultationList;
            }else if(searchSite!=NULL && searchStat!=NULL && searchDate!=NULL){
                consultationList = Database.query(querySiteAndStatusAndDate);
                system.debug('Third IF >>> '+consultationList);
                return consultationList;
            }else if(searchSite==NULL && searchStat!=NULL && searchDate!=NULL){
                consultationList = Database.query(queryStatusAndDate);
                system.debug('Fourth IF >>> '+consultationList);
                return consultationList;
            }else if(searchSite!=NULL && searchStat==NULL && searchDate!=NULL){
                consultationList = Database.query(querySiteAndDate);
                system.debug('Fifth IF >>> '+consultationList);
                return consultationList;
            }else if(searchSite==NULL && searchStat!=NULL && searchDate==NULL){
                consultationList = Database.query(queryStatus);
                system.debug('Sixth IF >>> '+consultationList);
                return consultationList;
            }else if(searchSite==NULL && searchStat==NULL && searchDate!=NULL){
                system.debug('Seventh IF >>> '+queryDate);
                consultationList = Database.query(queryDate);
                return consultationList;
            }else{
                system.debug('Last  IF >>> '+consultationList);
                return consultationList;
            }
        }
    }
}