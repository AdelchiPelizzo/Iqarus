/**
 * Created by Adelchi on 01/01/2018.
 */
({
    redir : function(){
        var urlEvent = $A.get("e.force:navigateToSObject");
        urlEvent.setParams({
            "recordId": newId,
            "slideDevName": "detail"});
        urlEvent.fire();
    }
})