/**
 * Created by Adelchi on 26/01/2018.
 */

global with sharing class SendEmailConsultationStatusReviewed2 {
    @future(callout=true)
    global static void sendEmailToMedic(List<Id> ConsultationId){
        Consultation__c consultation = [SELECT Id, Name, Client__r.Name, Client__c, Site__c FROM Consultation__c WHERE Id =: ConsultationId LIMIT 1];
        List<LinkSiteContact__c> linkSiteContactList = [SELECT Id, Contact__c, Site__c FROM LinkSiteContact__c WHERE Site__c =: consultation.Site__c ];
        List<String> listLSCIdStrings = new List<String>();
        List<String> listContactsIdString = new List<String>();
        List<String> listLSCSiteString = new List<String>();
        for(LinkSiteContact__c LSC : linkSiteContactList){
            listLSCIdStrings.add(LSC.Id);
            listContactsIdString.add(LSC.Contact__c);
            listLSCSiteString.add(LSC.Site__c);
        }
        system.debug(listContactsIdString);
        List<String> emailAddressesList = new List<String>();
        List<Contact> recipientsListM = [SELECT email, Medic_NOC_Recipient__c, Non_Medic_NOC_Recipient__c, Name FROM Contact WHERE Medic_NOC_Recipient__c = true AND Id IN : listContactsIdString ];
        if(recipientsListM.size()>0){
            for(Contact ct: recipientsListM){
                if(ct.email!=Null){
                    emailAddressesList.add(ct.email);
                }
            }
        }
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        PageReference pdf =  Page.EmailtoMedic;
        pdf.getParameters().put('id',(String)Consultation.Id);
        pdf.setRedirect(true);
        Blob b = pdf.getContent();
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName(Consultation.Name+' - Medical_Topside_Support_Contact_Report.pdf');
        efa.setBody(b);
        efa.setContentType('application/pdf');
        msg.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        system.debug(emailAddressesList);
        msg.setToAddresses(emailAddressesList);
        msg.setSubject('Topside Reviewed Consultation: '+ consultation.Name);
        msg.setHtmlBody('<!doctype html><html ><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><title>Iqarus.com Report</title><style>body{padding-top: 50px; padding-bottom: 20px;}column{float: left; padding: 15px;}.label{border-style: solid; border-color: coral; border-width: 1px; border-radius: 10px; width: 100%; color: black;}.paragraph{font-size: 23px;}p{font-size:15px;}footer{font-size: 7px; font-style: italic;}</style><body><div><ul><li style="list-style-type: none"><div style="float:right; margin-right: 125px"><img src="http://www.rsoh.co.uk/images/logos/iqarus-logo.png" height="95px"/></div><div style="float: left"><h2>Medical Topside Support</h2><h3>Contact Report</h3></div></li></ul></div><div style="float: left"><h4>Dear Doctor</h4><p>Please find attache a pdf version of data regarding an escalated or revised consultation record.</p><br></br><p>Best Regards</p><h5><strong>Iqarus.com</strong></h5></div></body></html></html>');
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {msg});
    }
}