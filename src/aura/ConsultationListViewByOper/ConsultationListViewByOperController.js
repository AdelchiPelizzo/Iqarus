/**
 * Created by Adelchi on 03/01/2018.
 */
({
    doInit: function(component, event, helper){
        console.log("start built");
        var searchTxt = component.get("v.siteName")
        var action = component.get("c.searchForConsultationsBySite");
        action.setParams({searchText : searchTxt});
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            var errors = response.getError();
            if(errors.length>0){console.log('error>>'+ errors[0].message)}
            if (state === "SUCCESS") {
                component.set("v.Consultation", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    navigate: function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        var ctarget = event.currentTarget;
        console.log('this should be the Id of the record clicked>>'+ctarget.dataset.value);
        navEvt.setParams({
            "recordId": ctarget.dataset.value
        });
        navEvt.fire();
        },

    sortByFUp: function(component, event, helper) {
        helper.sortBy(component, "Follow_up_required__c");
    },
    sortByOper: function(component, event, helper) {
        helper.sortBy(component, "Operator__c");
    }
})