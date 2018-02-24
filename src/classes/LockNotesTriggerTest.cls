/**
 * Created by Adelchi on 10/02/2018.
 */

@IsTest
private class LockNotesTriggerTest {
    public static Note nCont;
    public static Note nCons;
    public static Account a ;
    public static Consultation__c c;
    public static Site__c s;
    public static User uD;
    public static User u;
    public static Profile profileId;
    public static Contact contD;
    public static Contact cont;

    private static void generateTestData(){

        RecordType recType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Consult_Patient' LIMIT 1];
        a = new Account(
                Status__c = 'Active',
                Name = 'testAccount'
        );
        insert a;
        contD = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastNameD',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True
        );
        insert contD;
        cont = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastName',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True
        );
        insert cont;
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
        String siteId = c.Site__c;
        String siteName = [SELECT Name FROM Site__c WHERE Id =: siteId LIMIT 1].Name;
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
        system.debug(c.CreatedDate);
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
        nCons = new Note(
                ParentId = c.Id,
                Title = 'titleTest',
                Body = 'bodyTest'
        );
        insert nCons;

    }
    static testMethod void testBehavior () {
        Boolean result = false;
        generateTestData();
        test.startTest();
        system.runAs(u){
            try{update nCons;}catch(DmlException ex){result = true;}
            system.assertEquals(result, true);
            try{delete nCons;}catch(DmlException ex){result = true;}
            system.assertEquals(result, true);
        }
        system.runAs(uD){
            try{update nCons;}catch(DmlException ex){result = true;}
            system.assertEquals(result, true);
            try{delete nCons;}catch(DmlException ex){result = true;}
            system.assertEquals(result, true);
        }
        test.stopTest();
    }
}