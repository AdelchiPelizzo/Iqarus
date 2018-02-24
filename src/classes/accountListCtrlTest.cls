/**
 * Created by Adelchi on 02/02/2018.
 */

@IsTest
private class accountListCtrlTest {
    public static String objectName;
    public static String fld_API_Text;
    public static String fld_API_Val;
    public static Integer lim;
    public static String fld_API_Search;
    public static String searchText;

    public static Account generateTestData(){
        Account newAccount = new Account(
                Status__c = 'Active',
                Name = 'AccountTest'
        );
        insert newAccount;
        objectName = 'Account';
        fld_API_Text = 'Name';
        fld_API_Val = 'Id';
        lim = 4;
        fld_API_Search = 'Name';
        searchText = 'AccountT';
        return newAccount;

    }
    static testMethod void testBehavior () {
        Account account = generateTestData();
        String results = accountListCtrl.searchDB(objectName, fld_API_Text, fld_API_Val, lim, fld_API_Search, searchText);
        system.assertEquals('[{"val":"'+ Account.Id+ '","text":"'+Account.Name+'","objName":"Account"}]',results);
    }
}