/**
 * Created by Adelchi on 19/12/2017.
 */
({
    loadContacts : function(component, event, helper) {
        var name = component.get("v.contactName");
        var date = component.get("v.birthdate");
        var action = component.get("c.searchForContacts");
        action.setParams({searchText : name, searchDate : date});
        console.log(action);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contactList", response.getReturnValue());
            }
            /*var toastEvent = $A.get("e.force:showToast");
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
            toastEvent.fire();*/
        });
        $A.enqueueAction(action);
    },


})