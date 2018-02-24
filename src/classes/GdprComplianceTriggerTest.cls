/**
 * Created by Adelchi on 10/02/2018.
 */

@IsTest
private class GdprComplianceTriggerTest {

    public static Account a ;
    public static Contact contT;
    public static Contact contF;

    public static void generateTestData(){
        RecordType recType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Consult_Patient' LIMIT 1];
        a = new Account(
                Status__c = 'Active',
                Name = 'testAccount'
        );
        insert a;
        contT = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastName',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True
        );
        contF = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastName',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = False
        );
    }

    static testMethod void testBehavior () {
        Boolean resultT;
        Boolean resultF;
        generateTestData();
        test.startTest();
        try{
            insert contT;
        }catch(DmlException ex){
            resultT = false;
            system.debug(ex);
        }
        system.assertNotEquals(contT.Id, null);
        try{
            insert contF;
        }catch(DmlException ex){
             resultF = true;
            system.debug(ex);
        }
        system.assertEquals(resultF, true);
        test.stopTest();
    }
}