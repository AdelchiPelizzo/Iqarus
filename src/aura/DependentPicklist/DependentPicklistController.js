/**
 * Created by Adelchi on 26/02/2018.
 */
({

    doInit: function(component, event, helper) {
        //call the helper function with pass [component, Controller field and Dependent Field] Api name
        helper.fetchPicklistValues(component, 'OccupationCategory__c', 'OccupationTitle__c');
    },


    // function call on change tha controller field
    onControllerFieldChange: function(component, event, helper) {
        /*alert(event.getSource().get("v.value"));*/
        // get the selected value
        var controllerValueKey = event.getSource().get("v.value");

        // get the map values
        var Map = component.get("v.depnedentFieldMap");

        // check if selected value is not equal to None then call the helper function.
        // if controller field value is none then make dependent field value is none and disable field
        if (controllerValueKey != '--- None ---') {

            // get dependent values for controller field by using map[key].
            // for i.e "India" is controllerValueKey so in the map give key Name for get map values like
            // map['India'] = its return all dependent picklist values.
            var ListOfDependentFields = Map[controllerValueKey];
            helper.fetchDepValues(component, ListOfDependentFields);

        } else {
            var defaultVal = [{
                class: "optionClass",
                label: '--- None ---',
                value: '--- None ---'
            }];
            component.find('conState').set("v.options", defaultVal);
            component.set("v.isDependentDisable", true);
        }
    },

    // function call on change tha Dependent field
    onDependentFieldChange: function(component, event, helper) {
        console.log('FireOccupationalValuesSelected>>StartHere');
        var OccupationalValuesEvent = component.getEvent("FireWhenOccupationalValuesAreSelected");
        console.log("FireOccupationalValuesSelected"+OccupationalValuesEvent);
        var Cat = component.find('conCountry').get("v.value");
        var Tit = event.getSource().get("v.value");
        console.log("values>> "+Cat+'>> '+Tit);
        OccupationalValuesEvent.setParams({
            Category: Cat,
            Title: Tit
        });
        console.debug('end of params>>>'+OccupationalValuesEvent.getParam('Category'));
        OccupationalValuesEvent.fire();
        /*alert(event.getSource().get("v.value"));*/
    },
})