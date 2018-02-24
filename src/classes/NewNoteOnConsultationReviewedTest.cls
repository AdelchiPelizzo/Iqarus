/**
 * Created by Adelchi on 12/02/2018.
 */

@IsTest
private class NewNoteOnConsultationReviewedTest {
    public static Account a ;
    public static List<String> listConsultationsId;
    public static Site__c s;
    public static Consultation__c c;
    public static Note n;
    public static Note nD;
    private static Contact contD;
    private static Contact cont;
    private static User u;
    private static User uD;
    public static Profile p;
    public static Profile pD;

    private static void generateTestData(){
        p = [SELECT Id FROM Profile WHERE Name = 'Partner Community User -  Clone' LIMIT 1];
        pD = [SELECT Id FROM Profile WHERE Name = 'Partner Community User - Clone - Doctor' LIMIT 1];
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
        system.debug(a.Id);
        c = new Consultation__c(
                Status__c = 'In Progress',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02)
        );
        insert c;
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
        n = new Note(
                ParentId = c.Id,
                Title = 'titleTest',
                Body = 'bodyTest'
        );
        nD = new Note(
                ParentId = c.Id,
                Title = 'titleTest',
                Body = 'bodyTest'
        );
    }
    static testMethod void testBehavior () {
        generateTestData();
        Boolean result = true;
        test.startTest();
        system.runAs(u){
            try{
                insert n;
            }catch(DmlException ex){
                result = false;
            }
            system.assertEquals(result,true);
        }
        system.runAs(uD){
            result = true;
            try{
                insert nD;
            }catch(DmlException ex){
                result = false;
            }
            system.assertEquals(result,false);
        }
        test.stopTest();

    }
}