/**
 * Created by Adelchi on 07/02/2018.
 */

public without sharing class Announcements {
    @AuraEnabled
    public static String lastAnnouncement(){
        String ann = [SELECT Text_Body__c, CreatedDate FROM Community_Announcement__c ORDER BY CreatedDate DESC LIMIT 1].Text_Body__c;
        return ann;
    }
}