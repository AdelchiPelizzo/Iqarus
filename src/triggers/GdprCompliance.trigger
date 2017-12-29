/**
 * Created by Adelchi on 28/12/2017.
 */

trigger GdprCompliance on Contact (before insert) {
    for(Contact c : Trigger.New){
        if(c.GDPR__c == False){
            c.addError('Electronic Medical Record Information Sheet\n Iqarus is introducing an electronic medical records system to improve documentation, access, efficiency and\n coordination of your medical care.\n Your medical record will be held confidentially on the web based Salesforce platform. This platform uses industryaccepted\n encryption products to securely protect your data. Access to the record will be restricted to the medic,\n clinicians involved in your clinical care e.g. (Iqarus Topside Doctor) and the Operators Medical Advisor. We will\n only hold your identifiable record for as long as appropriate as detailed in our Control of Records Policy, which\n complies with HSE and MCA statutory requirements and mirrors the NHS policy for medical records retention.\n Anonymous data that cannot be traced back to you may be used by Iqarus for the purpose of studying and\n reporting the fitness of employees as a group e.g. studying the percentage of employees with high blood pressure\n to best target appropriate health promotion campaigns. By agreeing consent, you give permission for use of the\n electronic medical record system and disclosure of data for the said purposes.\n If you have any questions about your medical record please ask the medic.');
        }
    }
}