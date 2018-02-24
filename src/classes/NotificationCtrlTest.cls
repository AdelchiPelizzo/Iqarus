/**
 * Created by Adelchi on 09/02/2018.
 */

@IsTest
private class NotificationCtrlTest {
    public static Account a ;
    public static Consultation__c c;
    public static Consultation__c c1;
    public static Consultation__c c2;
    public static Site__c s;

    public static void generateTestData(){
        a = new Account(
                Status__c = 'Active',
                Name = 'testAccount'
        );
        insert a;
        s = new Site__c(
                Name = 'testSite',
                Account__c = a.Id,
                Site_Type__c = 'Office',
                Clinic_Code__c = 'testClinicCode',
                SAP_Customer_ID__c = 'testNAVId'
        );
        insert s;
        system.debug(s.Name);
        c = new Consultation__c(
                Status__c = 'In Progress',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c;

        c1 = new Consultation__c(
                Status__c = 'Closed with Follow up required',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c1;

        c2 = new Consultation__c(
                Status__c =  'Submitted for Topside supervision Locked',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c2;
    }

        static testMethod void testBehavior () {
            generateTestData();
            test.startTest();
            boolean a = NotificationCtrl.IsClosed(c.Id);
            system.assertEquals(a,false);
            boolean b = NotificationCtrl.IsLocked(c.Id);
            system.assertEquals(b,false);
            boolean a1 = NotificationCtrl.IsClosed(c1.Id);
            system.assertEquals(a1,true);
            boolean b1 = NotificationCtrl.IsLocked(c1.Id);
            system.assertEquals(b1,false);
            boolean a2 = NotificationCtrl.IsClosed(c2.Id);
            system.assertEquals(a2,false);
            boolean b2 = NotificationCtrl.IsLocked(c2.Id);
            system.assertEquals(b2,true);
            test.stopTest();
    }
}