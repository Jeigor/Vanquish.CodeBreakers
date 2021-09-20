({
	
    saveItem: function(component, item, callback) {
        let action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
    addItem: function(component, item) {
         this.saveItem(component, item, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                let items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
                //let clearAddFormEvent = component.getEvent("clearAddForm");
        		//addItemEvent.setParams();
        		//clearAddFormEvent.fire();
            }
             else{
                 
                 console.log("retrieving shop duties error:");
             }
        });
    },
    filterItemsHelper: function (component){
        let items = component.get('v.items');
        console.log(items);
        let weekdayCheckboxGroup = component.get('v.checkboxgroupvalueweekdays');
        let dutyDaysString = "";
        
        weekdayCheckboxGroup.forEach(weekdayCheckboxGroup => {
			console.log(weekdayCheckboxGroup);
            dutyDaysString += weekdayCheckboxGroup + ";";
		});
        
        var filteredItems = [];
        if(dutyDaysString.length>0){
            dutyDaysString = dutyDaysString.slice(0,-1);
            
            //console.log(e.Duty_Days__c);
            console.log(dutyDaysString);
           
            for(let i = 0; i < items.length; i++)
            {
            console.log("test");
            	console.log(items[i]["Duty_Days__c"]);
            	console.log(dutyDaysString);
            	console.log(i);
            	let dutyDaysStringInItems = items[i]["Duty_Days__c"];
            	console.log("testing string lists");
           	 	console.log(dutyDaysStringInItems);
            if(typeof dutyDaysStringInItems!=="undefined"){
            	let dutyDaysItems= dutyDaysStringInItems.split(';');
            	let dutyDaysStringList=dutyDaysString.split(";");
            	console.log(dutyDaysItems);
            //items[i][Duty_Days__c].forEach((e1)=> dutyDaysString.forEach((e2)=>
            		//{if(e1===e2){
            
           			 //console.log(e1);
            		//console.log(e2);
            		//filteredItems.push(items[i])}}));
            		//
            	for(let p = 0; p < dutyDaysItems.length; p++)
            	{ 
        			if(dutyDaysStringList.indexOf(dutyDaysItems[p])) {
            		filteredItems.push(items[i]);
            		console.log("item in list");
            		break;
            	
        			}
        		}
            	//if(items[i]["Duty_Days__c"]===dutyDaysString) {
            		//filteredItems.push(items[i]);
            		//console.log("items are equal")
            	
        		//}
        	}
        }
            component.set("v.filteredItems", filteredItems);
            console.log("filtered Items are :" +component.get("v.filteredItems"))
        }
            else{
            component.set("v.filteredItems", items);
        }
        
        
        
        
        
    }
})