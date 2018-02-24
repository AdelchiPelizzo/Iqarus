/**
 * Created by Adelchi on 08/01/2018.
 */
({
    sortBy: function(component, field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.Consultation");
        sortAsc = field == sortField? !sortAsc: true;
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = a[field] > b[field];
            return t1? 0: (sortAsc?-1:1)*(t2?-1:1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.Consultation", records);
    },

    loadOptions: function(component, event, helper){
        var action1 = component.get("c.getPicklistValues");
        action1.setCallback(this, function(response) {
            var state = response.getState();
            /*var errors = response.getError();
            if(errors.length>0){console.log('error>>'+ errors[0].message)}*/
            if (state === "SUCCESS") {
                component.set("v.statusList",response.getReturnValue());
                /* var list = '';
                 var optionList = response.getReturnValue();
                 console.log('optionlist>>'+optionList);
                 for(var i=0; optionList.length; i++){
                     console.log('>>>> '+JSON.stringify(optionList[i]))
                     list.add(JSON.stringify(optionList[i]));
                 }

                 component.set("v.statusList", list);*/
            }
        });
        $A.enqueueAction(action1);
    },

})