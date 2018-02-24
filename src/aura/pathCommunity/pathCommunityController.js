/**
 * Created by Adelchi on 24/01/2018.
 */
({
    handleSelect : function (component, event, helper) {
        var stepName = event.getParam("detail").value;
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "Toast from " + stepName
        });
        toastEvent.fire();
    },

    doInit : function(){
        $A.get('e.force:refreshView').fire();
    },

    refresh : function(component, event, helper) {
        var action = cmp.get('c.myController');
        action.setCallback(cmp,
            function(response) {
                var state = response.getState();
                if (state === 'SUCCESS'){
                    $A.get('e.force:refreshView').fire();
                } else {
                    //do something
                }
            }
        );
        $A.enqueueAction(action);
    }
})