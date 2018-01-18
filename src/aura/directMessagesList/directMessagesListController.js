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
                    var messageList = [];
                    messageList = resNoQuotAll2.split("</p>");
                    var i;
                    var messageSingle = [];
                    for(i=0; i<messageList.length; i++){
                        messageList[i].split("<p>");
                    }
                    console.log('This the message List>>'+messageList);
                    component.set("v.messageList", messageList);
                    component.set("v.messageMapValue", resNoQuotAll2);
                    component.set("v.messageMap" , response.getReturnValue());
                }else if (state === "INCOMPLETE") {

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
    }
})