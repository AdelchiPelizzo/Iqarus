/**
 * Created by Adelchi on 03/01/2018.
 */
({
    doInit: function(component, event, helper){
        var searchBySite = component.get("v.siteName");
        var searchByStatus = component.get("v.status");
        var searchByDate = component.get("v.CreatedDate");
        var action = component.get("c.searchForConsultations");
        action.setParams({searchSite : searchBySite, searchStatus: searchByStatus, searchDate: searchByDate});
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state in action >> '+state);
            var errors = response.getError();
            if(errors.length>0){console.log('error>>'+ errors[0].message)}
            if (state === "SUCCESS") {
                component.set("v.Consultation", response.getReturnValue());
            }
        });
        var action1 = component.get("c.getPicklistValues");
        action1.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            /*var errors = response.getError();
            if(errors.length>0){console.log('error>>'+ errors[0].message)}*/
            if (state === "SUCCESS") {
                component.set("v.statusList",response.getReturnValue());
                console.log(component.get("v.statusList"));
               /* var list = '';
                var optionList = response.getReturnValue();
                console.log('optionlist>>'+optionList);
                for(var i=0; optionList.length; i++){
                    console.log('>>>> '+JSON.stringify(optionList[i]))
                    list.add(JSON.stringify(optionList[i]));
                }

                component.set("v.statusList", list);*/
            }
        });
        $A.enqueueAction(action);
        $A.enqueueAction(action1);
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