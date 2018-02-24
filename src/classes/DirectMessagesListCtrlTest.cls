/**
 * Created by Adelchi on 09/02/2018.
 */

@IsTest
private class DirectMessagesListCtrlTest {

    public static Account a ;
    public static User u;
    public static Profile profileId;
    public static Contact cont;

    public static void generateTestData(){
        RecordType recType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Consult_Patient' LIMIT 1];
        a = new Account(
                Status__c = 'Active',
                Name = 'testAccount'
        );
        insert a;
        cont = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastName',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True
        );
        insert cont;
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Partner Community User -  Clone' LIMIT 1];
        u = new User(
                LastName = 'Last',
                FirstName='James',
                Alias = 'jlas',
                Email = 'test@test.test',
                Username = 'test@iqarus.iqarus',
                ProfileId = p.Id,
                TimeZoneSidKey = 'GMT',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LocaleSidKey = 'en_US',
                ContactId = cont.Id
        );
        insert u;


    }

    static testMethod void testBehavior () {
        generateTestData();
        system.runAs(u);
        test.startTest();
        DirectMessagesListCtrl.getDirectMessages();
        test.stopTest();

    }
}