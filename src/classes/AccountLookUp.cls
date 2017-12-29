/**
 * Created by Adelchi on 28/12/2017.
 */

public with sharing class AccountLookUp {

    @AuraEnabled
    public static List<Account> searchForAccounts(String searchName) {
        List<Account> accList = new List<Account>();
        String query1 = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%'+ searchName + '%\' ORDER by Name ASC LIMIT 10 ';
        accList = [SELECT Id, Name FROM Account ORDER by Name ASC LIMIT 10];
        if(searchName!=NULL ){
            return accList = Database.query(query1);
        }else{
            return contactList;
        }
    }
}