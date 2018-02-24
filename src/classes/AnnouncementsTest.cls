/**
 * Created by Adelchi on 08/02/2018.
 */

@IsTest
private class AnnouncementsTest {
    public static Community_Announcement__c cAnn;
    public static void  buildTestData(){
        cAnn = new Community_Announcement__c(
                Text_Body__c = 'Test Announcement'
        );
        insert cAnn;
    }
    static testMethod void testBehavior () {
        buildTestData();
        test.startTest();
        Announcements.lastAnnouncement();
        system.assertEquals('Test Announcement',cAnn.Text_Body__c);
        test.stopTest();
    }
}