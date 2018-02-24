/**
 * Created by Adelchi on 26/01/2018.
 */

global class SendEmailConsultationStatusReviewed {
    @future(callout=true)
    global static void sendEmailToMedicAndNonMedic(List<String> ConsultationId){
        Consultation__c consultation = [SELECT Name, Client__r.Name, Client__c, Site__c FROM Consultation__c WHERE Id =: ConsultationId LIMIT 1];
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
        List<String> emailAddressesListM = new List<String>();
        List<String> emailAddressesListNonM = new List<String>();
        List<Contact> recipientsListNonM = [SELECT email, Medic_NOC_Recipient__c, Non_Medic_NOC_Recipient__c, Name FROM Contact WHERE Non_Medic_NOC_Recipient__c = true AND Id IN : listContactsIdString];
        system.debug(recipientsListNonM);
        List<Contact> recipientsListM = [SELECT email, Medic_NOC_Recipient__c, Non_Medic_NOC_Recipient__c, Name FROM Contact WHERE Medic_NOC_Recipient__c = true AND Id IN : listContactsIdString ];
        system.debug(recipientsListM);
        if(recipientsListM.size()>0){
            for(Contact ct: recipientsListM){
                if(ct.email!= Null){
                    emailAddressesListM.add(ct.email);
                }
            }
        }
        if(recipientsListNonM.size()>0){
            for(Contact ct: recipientsListNoNM){
                if(ct.email!=Null){
                    emailAddressesListNonM.add(ct.email);
                }
            }
        }
        Messaging.SingleEmailMessage msgM = new Messaging.SingleEmailMessage();
        Messaging.SingleEmailMessage msgNonM = new Messaging.SingleEmailMessage();
        if(emailAddressesListM.size()>0){
            PageReference pdf =  Page.EmailtoMedic;
            pdf.getParameters().put('id',(String)Consultation.Id);
            pdf.setRedirect(true);
            Blob b = pdf.getContent();
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(Consultation.Name+' - Medical_Topside_Support_Contact_Report.pdf');
            efa.setBody(b);
            efa.setContentType('application/pdf');
            msgM.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            system.debug(emailAddressesListM);
            msgM.setToAddresses(emailAddressesListM);
            msgM.setSubject('Topside Reviewed Consultation: '+ consultation.Name);
            msgM.setHtmlBody('<!doctype html><html ><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><title>Iqarus.com Report</title><style>body{padding-top: 50px; padding-bottom: 20px;}column{float: left; padding: 15px;}.label{border-style: solid; border-color: coral; border-width: 1px; border-radius: 10px; width: 100%; color: black;}.paragraph{font-size: 23px;}p{font-size:15px;}footer{font-size: 7px; font-style: italic;}</style><body><div><ul><li style="list-style-type: none"><div style="float:right; margin-right: 125px"><img src="http://www.rsoh.co.uk/images/logos/iqarus-logo.png" height="95px"/></div><div style="float: left"><h2>Medical Topside Support</h2><h3>Contact Report</h3></div></li></ul></div><div style="float: left"><h4>Dear Doctor</h4><p>Please find attache a pdf version of data regarding an escalated or revised consultation record.</p><br></br><p>Best Regards</p><h5><strong>Iqarus.com</strong></h5></div></body></html></html>');
            msgM.setToAddresses(emailAddressesListM);
            Messaging.SendEmailResult [] rmsgM = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {msgM});
        }
        if(emailAddressesListNonM.size()>0){
            PageReference pdf =  Page.EmailtoNonMedic;
            pdf.getParameters().put('id',(String)Consultation.Id);
            pdf.setRedirect(true);
            Blob b = pdf.getContent();
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(Consultation.Name+' - Medical_Topside_Support_Contact_Report.pdf');
            efa.setBody(b);
            efa.setContentType('application/pdf');
            msgNonM.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            system.debug(emailAddressesListNonM);
            msgNonM.setToAddresses(emailAddressesListNonM);
            msgNonM.setSubject('Topside Reviewed Consultation: '+ consultation.Name);
            msgNonM.setHtmlBody('<!doctype html><html ><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><title>Iqarus.com Report</title><style>body{padding-top: 50px; padding-bottom: 20px;}column{float: left; padding: 15px;}.label{border-style: solid; border-color: coral; border-width: 1px; border-radius: 10px; width: 100%; color: black;}.paragraph{font-size: 23px;}p{font-size:15px;}footer{font-size: 7px; font-style: italic;}</style><body><div><ul><li style="list-style-type: none"><div style="float:right; margin-right: 125px"><img src="http://www.rsoh.co.uk/images/logos/iqarus-logo.png" height="95px"/></div><div style="float: left"><h2>Medical Topside Support</h2><h3>Contact Report</h3></div></li></ul></div><div style="float: left"><h4>Dear Doctor</h4><p>Please find attache a pdf version of data regarding an escalated or revised consultation record.</p><br></br><p>Best Regards</p><h5><strong>Iqarus.com</strong></h5></div></body></html></html>');
            msgNonM.setToAddresses(emailAddressesListNonM);
            Messaging.SendEmailResult [] rmsgNonM = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {msgNonM});
        }
    }
}