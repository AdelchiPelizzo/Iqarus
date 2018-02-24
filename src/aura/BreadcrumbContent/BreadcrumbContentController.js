/**
 * Created by Adelchi on 23/01/2018.
 */
({
    setNavigation : function(component, event, helper) {
        var cmpEvent = component.getEvent("cmpEvent");
        var index = component.get("v.index");

        https://uat-iqarus.cs89.force.com/MedicsOnLine/s/?tabset-7fd91=31386
        cmpEvent.setParams({"navIndexEvent" : index});
        cmpEvent.fire();
    }
})