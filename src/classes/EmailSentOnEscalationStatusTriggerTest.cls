/**
 * Created by Adelchi on 09/02/2018.
 */

@IsTest
private class EmailSentOnEscalationStatusTriggerTest {
    public static Consultation__c c;
    public static Consultation__c c1;
    public static Consultation__c c2;
    public static Account a ;
    public static Site__c s;
    public static User u;
    public static User uD;
    public static Contact cont;
    public static Contact contD;

    static void init(){
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
        contD = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastNameD',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True
        );
        insert contD;
        s = new Site__c(
                Name = 'testSite',
                Account__c = a.Id,
                Site_Type__c = 'Office',
                Clinic_Code__c = 'testClinicCode',
                SAP_Customer_ID__c = 'testNAVId'
        );
        insert s;
        c = new Consultation__c(
                Status__c = 'Submitted for Topside supervision Locked',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c;
        c1 = new Consultation__c(
                Status__c = 'Topside Reviewed Locked',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c1;
        c2 = new Consultation__c(
                Status__c = 'Closed',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c2;
        Profile p = [SELECT Id FROM Profile WHERE Name = '' LIMIT 1];
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
        Profile pD = [SELECT Id FROM Profile WHERE Name = 'Partner Community User - Clone - Doctor' LIMIT 1];
        uD = new User(
                LastName = 'LastD',
                FirstName='JamesD',
                Alias = 'jlasD',
                Email = 'test@test.testD',
                Username = 'test@iqarus.iqarusD',
                ProfileId = pD.Id,
                TimeZoneSidKey = 'GMT',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LocaleSidKey = 'en_US',
                ContactId = contD.Id
        );
        insert uD;
    }

    static testMethod void testBehavior() {
    init();
    test.startTest();
        system.runAs(u){
            update c;
            system.assertEquals(true,true);
            update c1;
            system.assertEquals(true,true);
        }
        system.runAs(uD){
            update c;
            system.assertEquals(true,true);
            update c1;
            system.assertEquals(true,true);
        }
    test.stopTest();
    }
}