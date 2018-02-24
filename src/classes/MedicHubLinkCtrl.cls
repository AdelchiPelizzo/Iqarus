/**
 * Created by Adelchi on 15/02/2018.
 */

public with sharing class MedicHubLinkCtrl {

    @AuraEnabled
    public static List<Medic_Hub_Link__c> getMedicHubLinks() {
        List<Medic_Hub_Link__c> MedicHuBLinks = [SELECT Id, Name, URL__c FROM Medic_Hub_Link__c];
        system.debug('list of links >> '+MedicHuBLinks);
        return MedicHuBLinks;
    }
}