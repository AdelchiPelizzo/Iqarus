/**
 * Created by Adelchi on 19/12/2017.
 */
({
    doInit: function (component, event, helper)
    {
        helper.loadContacts(component);
    },

 handleClick: function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": event.target.id
        });
        navEvt.fire();
    }
})