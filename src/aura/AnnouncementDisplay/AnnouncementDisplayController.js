/**
 * Created by Adelchi on 07/02/2018.
 */
({
    doInit : function(component, event, helper) {
        console.log('start do init >>>');
        var action = component.get("c.lastAnnouncement");
        var toastEvent;
        action.setCallback(this, function(response){
            var state = response.getState();
            var errors = response.getError();
            var announcement = response.getReturnValue();

            console.log('text body  >>>'+ announcement);
            if(errors.length>0){console.log('error>>'+ errors[0].message)}
            if (state === "SUCCESS"){
                toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    type: 'warning',
                    title: 'General Announcement: '+announcement,
                        mode: 'dismissable',
                    duration: 300000,
                    message: '--- medics online ---',
                    });

            }toastEvent.fire();
        });
        $A.enqueueAction(action);

    }
})