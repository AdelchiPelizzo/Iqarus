/**
 * Created by Adelchi on 09/02/2018.
 */

@IsTest
private class ContactSearchCtrlTest {
    public static Account a ;
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
    }

    static testMethod void testBehavior () {
        generateTestData();
        test.startTest();
        List<Contact> contactsList = ContactSearchCtrl.searchForContacts('testLastName','2000-01-01');
        system.assertEquals(contactsList[0].Id, cont.Id);
        contactsList = ContactSearchCtrl.searchForContacts(null,'2000-01-01');
        system.assertEquals(contactsList[0].Id, cont.Id);
        contactsList = ContactSearchCtrl.searchForContacts('testLastName',null);
        system.assertEquals(contactsList[0].Id, cont.Id);
        contactsList = ContactSearchCtrl.searchForContacts(null,null);
        system.assertEquals(contactsList[0].Id, cont.Id);
        test.stopTest();
    }
}