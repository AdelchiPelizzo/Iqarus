/**
 * Created by Adelchi on 20/12/2017.
 */

public with sharing class ContactCreationCtrl {
    @AuraEnabled
    public static Contact saveContact(boolean bool) {
        Contact cnt = new Contact();
        cnt.GDPRCompliant__c = bool;
        insert cnt;
        return cnt;
    }
}