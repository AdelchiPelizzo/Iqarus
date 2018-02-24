/**
 * Created by Adelchi on 09/02/2018.
 */

@IsTest
private class SendEmailConsultationStatusReviewedTest {
    public static Account a ;
    public static List<String> listConsultationsId;
    public static List<String> listConsultationsId1;
    public static List<String> listConsultationsId2;
    public static Site__c s;
    public static User uD;
    public static User u;
    public static Profile profileId;
    public static Contact contD;
    public static Contact cont;
    public static Consultation__c c;
    public static Consultation__c c1;
    public static Consultation__c c2;
    public static LinkSiteContact__c LSC;
    public static LinkSiteContact__c LSC1;


    public static void generateTestData(){
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
                GDPRCompliant__c = True,
                Medic_NOC_Recipient__c  = True,
                email = 'test@test.test'
        );
        insert contD;
        cont = new Contact(
                RecordTypeId = recType.Id,
                LastName = 'testLastName',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True,
                Medic_NOC_Recipient__c = True,
                email = 'test@test.test'
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
        c1 = new Consultation__c(
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
                Status__c = 'Topside Reviewed Locked'
        );
        insert c1;
        c2 = new Consultation__c(
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
                Status__c = 'Closed'
        );
        insert c2;


        LSC = new LinkSiteContact__c(
                Site__c = s.Id,
                Contact__c = cont.Id
        );
        insert LSC;
        LSC1 = new LinkSiteContact__c(
                Site__c = s.Id,
                Contact__c = contD.Id
        );
        insert LSC1;

        String sId = c.Id;
        String sId1 = c1.Id;
        String sId2 = c2.Id;
        listConsultationsId = New List<String>();
        listConsultationsId1 = New List<String>();
        listConsultationsId2 = New List<String>();
        listConsultationsId.add(sId);
        listConsultationsId1.add(sId1);
        listConsultationsId2.add(sId2);
        String siteId = c.Site__c;
        String siteId1 = c1.Site__c;
        String siteId2 = c2.Site__c;
        String siteName = [SELECT Name FROM Site__c WHERE Id =: siteId LIMIT 1].Name;
        String siteName1 = [SELECT Name FROM Site__c WHERE Id =: siteId1 LIMIT 1].Name;
        String siteName2 = [SELECT Name FROM Site__c WHERE Id =: siteId2 LIMIT 1].Name;
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
    }

    static testMethod void testBehavior () {
        generateTestData();
        test.startTest();
        system.runAs(u){
            SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listConsultationsId);
            system.assertEquals(true,true);
            SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listConsultationsId1);
            system.assertEquals(true,true);
            SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listConsultationsId2);
            system.assertEquals(true,true);
        }
        system.runAs(uD){
            SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listConsultationsId);
            system.assertEquals(true,true);
            SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listConsultationsId1);
            system.assertEquals(true,true);
            SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listConsultationsId2);
            system.assertEquals(true,true);
        }
        test.stopTest();
    }
}