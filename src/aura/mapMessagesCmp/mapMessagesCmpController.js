/**
 * Created by Adelchi on 17/02/2018.
 */
({
    doInit : function(component, event, helper) {
        var key = component.get("v.key");
        var map = component.get("v.map");

        // set the values of map to the value attribute
        // to get map values in lightning component use "map[key]" syntax.
        component.set("v.value" , map[key]);
    },
})