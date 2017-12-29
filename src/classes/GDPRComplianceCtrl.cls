/**
 * Created by Adelchi on 28/12/2017.
 */

public with sharing class GDPRComplianceCtrl {

    public static Pagereference redirect(){
        system.debug('halleluja!');
        Pagereference pageRef = New PageReference('https://www.google.com');
        pageref.setRedirect(true);
        return pageRef;

    }

}