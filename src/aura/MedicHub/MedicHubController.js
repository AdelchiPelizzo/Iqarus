/**
 * Created by Adelchi on 15/02/2018.
 */
({
    doInit: function(component, event, helper) {
        var action = component.get("c.getMedicHubLinks");
        action.setCallback(this, function(response) {
            var state = response.getState();
            var errors = response.getError();
            console.log('medic hub state >> '+state+' >> medic hub error >> '+errors);
            var res = response.getReturnValue();
            console.log('medic hub list of links here >> '+res);
            if (errors.length > 0) {
                console.log('error>>' + errors[0].message)
            }
            if (state === "SUCCESS") {
                component.set('v.Links', res);
            }
        });
        $A.enqueueAction(action);
    }
})