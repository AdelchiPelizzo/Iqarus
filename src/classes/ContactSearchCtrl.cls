/**
 * Created by Adelchi on 19/12/2017.
 */

public with sharing class ContactSearchCtrl {

    @AuraEnabled
    public static List<Contact> searchForContacts(String searchText, String searchDate) {
        Date newDate;
        system.debug(searchDate);
        system.debug(searchText);
        /*String newSearchDate = searchDate.format();*/
        List<Contact> contactList = new List<Contact>();
        String query1 = 'SELECT Account.Name, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Name LIKE \'%'+ searchText + '%\' AND RecordType.DeveloperName = \'Consult_Patient\' ORDER by lastName ASC LIMIT 10 ';
        String query2 = 'SELECT Account.Name, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Birthdate = '+newDate+' AND RecordType.DeveloperName = \'Consult_Patient\' ORDER by BirthDate ASC LIMIT 10 ';
        String query3 = 'SELECT Account.Name, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Name LIKE \'%'+ searchText + '%\' AND Birthdate = '+newDate+' AND RecordType.DeveloperName = \'Consult_Patient\' ORDER by lastName ASC LIMIT 10 ';
        contactList = [SELECT Account.Name, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE RecordType.DeveloperName = 'Consult_Patient' LIMIT 10];
        if(searchText!=NULL && searchDate == NULL){
            return contactList = Database.query(query1);
        }else if(searchText==NULL && searchDate!=NULL){
            newDate = Date.valueOf(searchDate);
            return contactList = Database.query(query2);
        }else if(searchText!=NULL && searchDate!=NULL){
            newDate = Date.valueOf(searchDate);
            return contactList = Database.query(query3);
        }else{
            return contactList;
        }
    }
}