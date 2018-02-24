/**
 * Created by Adelchi on 17/02/2018.
 */
({
    fetchMapCtrl: function(component, event, helper) {
        //call apex class method
        var action = component.get('c.getDirectMessages');
        action.setCallback(this, function(response) {
            //store response state
            var state = response.getState();
            if (state === "SUCCESS") {
                // create a empty array for store map keys
                var arrayOfMapKeys = [];
                // store the response of apex controller (return map)
                var StoreResponse = response.getReturnValue();
                console.log('StoreResponse' + StoreResponse);
                // set the store response[map] to component attribute, which name is map and type is map.
                component.set('v.fullMap', StoreResponse);

                for (var singlekey in StoreResponse) {
                    arrayOfMapKeys.push(singlekey);
                }
                // Set the all list of keys on component attribute, which name is lstKey and type is list.
                component.set('v.lstKey', arrayOfMapKeys);
            }
        });
        // enqueue the Action
        $A.enqueueAction(action);
    },
})