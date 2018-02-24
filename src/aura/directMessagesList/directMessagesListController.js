/**
 * Created by Adelchi on 04/01/2018.
 */
({
    doInit : function(component){
        var action = component.get("c.getDirectMessages");
        action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var res = JSON.stringify(response.getReturnValue());
                    var resNobracketsL = res.replace(new RegExp("{", "g"), '');
                    var resNobracketsR = resNobracketsL.replace(new RegExp("}", "g"), '');
                    var resNoQuot = resNobracketsR.replace(new RegExp("\"", "g"), '');
                    var resNoQuotAll = resNoQuot.replace(new RegExp(":","g"),"");
                    var resNoQuotAll2 = resNoQuotAll.replace(new RegExp(",", "g"),"");
                    var messageList = resNoQuotAll2.split("</p>");
                    console.log('messageList>>>'+messageList);

                    var messageSbjBody =  function (Sbj, Bd) {
                        this.Subject = Sbj;
                        this.Body = Bd;
                    }

                    var messageSingle = [];
                    for( var i=0; i<messageList.length; i++){
                        console.log('msg.split>>>>in for loop>>'+messageList[i].split("<p>"));
                        var m1 = messageList[i].split("<p>");
                        var subject = '';
                        var body = '';
                        subject = m1[0];
                        body = m1[1];
                        var m = new messageSbjBody(subject, body);
                        messageSingle.push(m);
                        console.log('messageSbjBody>>>'+m);
                    }
                    console.log('This the message List>>'+messageList);
                    console.log('This the message Single >> '+messageSingle);
                    component.set("v.messageList", messageList);
                    component.set("v.messageSingle", messageSingle);
                    component.set("v.messageMapValue", resNoQuotAll2);
                    component.set("v.messageMap" , response.getReturnValue());
                    /* var getMapKeySet = function(key, value){
                        var message = '';
                        var subject = '';
                        this.subject = key;
                        this.message = value;
                        return [subject,message];
                    };
                    var mapString = response.getReturnValue();
                    var mappedSubjBody = mapString.map(getMapKeySet());
                    for(String m){

                    }
                    console.log('mappedSubjBody>>>    '+mappedSubjBody);
                    component.set("v.messageMap" , mappedSubjBody);*/

                }else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                    console.log("Error message: " +  errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },

    fetchMapCtrl: function(component, event, helper) {
        console.log('fetchMapCtrl started >> Here!!');
        //call apex class method
        var action = component.get('c.getDirectMessages');
        action.setCallback(this, function(response) {
            //store response state
            var state = response.getState();
            if (state === "SUCCESS") {
                // create a empty array for store map keys
                var arrayOfMapKeys = [];
                // store the response of apex controller (return map)
                var StoreResponse = JSON.stringify(response.getReturnValue());
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