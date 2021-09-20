({
       // Load camping items from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        let action = component.get("c.getItems");
        //action.setParams({'active': true })
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
                
                console.log('success loading records');
                helper.filterItemsHelper(component);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
	handleAddItem: function(component, event, helper) {
        console.log('hadleadditem fired')
        let newItem = event.getParam("item");
        //console.log(newItem);
        helper.addItem(component, newItem);
        helper.filterItemsHelper(component);
    },
    
    handleListViewCheckboxGroupWeekdaysChange: function(component, event, helper){
        console.log(component.get('v.items'));
        helper.filterItemsHelper(component);
    },
    handleListViewCheckboxGroupActiveChange: function(component, event, helper){
        const changeValue = component.get("v.checkboxgroupvalueactive");
        console.log(changeValue);
        
    }
    /*
     createItem: function(component, item) {
         let action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                let items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
            }
        });
        $A.enqueueAction(action);
         
         
    }
    */
})