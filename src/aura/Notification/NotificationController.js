/**
 * Created by Adelchi on 10/01/2018.
 */
({
    doInit: function(component) {
        // Set the attribute value.
        // You could also fire an event here instead.
        var id = component.find("ConsultationRecordLoader").get("v.recordId");
        var action = component.get("c.IsClosed");
        action.setParams({ recordId : id});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response.getReturnValue()'+response.getReturnValue());
                component.set("v.isClosed", response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        var action1 = component.get("c.IsLocked");
        action1.setParams({ recordId : id});
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response.getReturnValue()'+response.getReturnValue());
                component.set("v.isLocked", response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
        $A.enqueueAction(action1);
    }
})
