/**
 * Created by Adelchi on 23/01/2018.
 */
({
    setNavigationEvent : function(component, event, helper){

        var index = event.getParam("navIndexEvent");
        var navbNew = [];
        var navb = component.get("v.FixedBreadcrumbs");
        for(var i=0; i<=index; i++){
            navbNew.push(navb[i]);
        }
        component.set("v.itemName",navb[index]);
        component.set("v.Breadcrumbs",navbNew);
    },
    next : function(component, event, helper){
        var navb = component.get("v.FixedBreadcrumbs");
        var navbNew = component.get("v.Breadcrumbs");
        var len = navbNew.length;
        navbNew.push(navb[len]);
        component.set("v.itemName",navb[len]);
        component.set("v.Breadcrumbs",navbNew);
    }
})