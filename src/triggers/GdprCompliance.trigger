/**
 * Created by Adelchi on 28/12/2017.
 */

trigger GdprCompliance on Contact (before insert, after update) {
    String recTypeId = [SELECT Id FROM RecordType WHERE Name = 'Consult Patient' LIMIT 1].Id;
    if(trigger.isInsert){
        for(Contact c : Trigger.New){
            if(c.GDPRCompliant__c == False && c.RecordTypeId==recTypeId){
                c.addError('<p style="color:red">Electronic Medical Record Information Sheet' +
                        'Iqarus is introducing an electronic medical records system to improve documentation, access, efficiency and' +
                        'coordination of your medical care.' +
                        'Your medical record will be held confidentially on the web based Salesforce platform. This platform uses industry accepted' +
                        'encryption products to securely protect your data. Access to the record will be restricted to the medic,' +
                        'clinicians involved in your clinical care e.g. (Iqarus Topside Doctor) and the Operators Medical Advisor. We will' +
                        'only hold your identifiable record for as long as appropriate as detailed in our Control of Records Policy, which' +
                        'complies with HSE and MCA statutory requirements and mirrors the NHS policy for medical records retention.' +
                        'Anonymous data that cannot be traced back to you may be used by Iqarus for the purpose of studying and' +
                        'reporting the fitness of employees as a group e.g. studying the percentage of employees with high blood pressure' +
                        'to best target appropriate health promotion campaigns. By agreeing consent, you give permission for use of the' +
                        'electronic medical record system and disclosure of data for the said purposes.' +
                        'If you have any questions about your medical record please ask the medic.<p>');
            }
        }
    }
    if(trigger.isUpdate){
        for(Contact cNew : Trigger.New){
            Contact cOld = Trigger.oldMap.get(cNew.Id);
            if(cNew.GDPRCompliant__c != cOld.GdprCompliant__c){
                cNew.addError('Cannot modifiy GDPR Compliancy after the Contact has been created');
            }
        }
    }
}