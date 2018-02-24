/**
 * Created by Adelchi on 20/12/2017.
 */
({
    doInit: function(component, event, helper) {
        helper.fetchPickListVal(component, 'OccupationCategory__c', 'occField');
        helper.fetchPickListVal(component, 'Gender__c', 'gender');

        // Prepare a new record from template

        component.find("contactRecordCreator").getNewRecord(
            "Contact", // sObject type (objectApiName)
            //"0120E0000005EJ0QAM", // recordTypeId
            null,
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newContact");
                var error = component.get("v.newContactError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
        );
    },

    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        component.set("v.occInfo", event.getSource().get("v.value"));
    },

    onPicklistChange1: function(component, event, helper) {
    component.set("v.gender", event.getSource().get("v.value"));},

    handleSaveContact: function(component, event, helper) {
        var check = confirm("Electronic Medical Record Information Sheet\n" +
            "Iqarus is introducing an electronic medical records system to improve documentation, access, efficiency and\n" +
            "coordination of your medical care.\n" +
            "Your medical record will be held confidentially on the web based Salesforce platform. This platform uses industryaccepted\n" +
            "encryption products to securely protect your data. Access to the record will be restricted to the medic,\n" +
            "clinicians involved in your clinical care e.g. (Iqarus Topside Doctor) and the Operators Medical Advisor. We will\n" +
            "only hold your identifiable record for as long as appropriate as detailed in our Control of Records Policy, which\n" +
            "complies with HSE and MCA statutory requirements and mirrors the NHS policy for medical records retention.\n" +
            "Anonymous data that cannot be traced back to you may be used by Iqarus for the purpose of studying and\n" +
            "reporting the fitness of employees as a group e.g. studying the percentage of employees with high blood pressure\n" +
            "to best target appropriate health promotion campaigns. By agreeing consent, you give permission for use of the\n" +
            "electronic medical record system and disclosure of data for the said purposes.\n" +
            "If you have any questions about your medical record please ask the medic. ");
        if(check) {
            component.set("v.myBool", "False");
            component.set("v.simpleNewContact.AccountId", component.get("v.selItem2.val"));
            component.set("v.simpleNewContact.OccupationCategory__c", component.get("v.occInfo"));
            component.set("v.simpleNewContact.Gender__c", component.get("v.gender"));
            component.find("contactRecordCreator").saveRecord(function(saveResult) {
                var newId = saveResult.recordId;
                console.log('save result state>>'+JSON.stringify(saveResult.error));
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");

                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire();
                    var urlEvent = $A.get("e.force:navigateToSObject");
                    urlEvent.setParams({
                        "recordId" : newId,
                        "isredirect": "true"
                    })
                    urlEvent.fire();

                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saving Error",
                        "message": JSON.stringify(saveResult.error)
                    });
                    resultsToast.fire();
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
            });
            helper.redir();
        }
    }

})