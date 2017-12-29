/**
 * Created by Adelchi on 20/12/2017.
 */
({
    doInit: function(component, event, helper) {
        // Prepare a new record from template
        /*   var action = component.get("c.getAccounts");
          action.setCallback(this, function(response) {
              var state = response.getState();
              if(state === "SUCCESS") {
                  component.set("v.accounts", response.getReturnValue());
              } else {
                  console.log('Problem getting account, response state: ' + state);
              }
          });
          $A.enqueueAction(action);
         component.set("accounts", )*/
        component.find("contactRecordCreator").getNewRecord(
            "Contact", // sObject type (objectApiName)
            "0120E0000005EJ0QAM", // recordTypeId
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
        /*if(helper.validateContactForm(component)) {*/
            component.set("v.simpleNewContact.AccountId", component.get("v.selItem2.val"));
            component.find("contactRecordCreator").saveRecord(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire();

                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    console.log('Problem saving contact, error: ' + JSON.stringify(saveResult.error));
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
            });

    }

/*    save : function(component, event, helper) {
        var gdpr = window.confirm("You MUST get acceptance from Patient to store  personal data.");
        var action = component.get("c.saveContact");
        action.setParams({ "bool" : gdpr});
        $A.enqueueAction(action);
        if (state === "SUCCESS") {
            component.set("v.newContact", response.getReturnValue());
        }else{
            var toastEvent = $A.get("e.force:showToast");
            if (state === 'SUCCESS'){
                toastEvent.setParams({
                    "title": "Success!",
                    "message": " Your contacts have been loaded successfully."
                });
            }
            else {
                toastEvent.setParams({
                    "title": "Error!",
                    "message": " Something has gone wrong."
                });
            }
            toastEvent.fire();

        }
    }*/
})