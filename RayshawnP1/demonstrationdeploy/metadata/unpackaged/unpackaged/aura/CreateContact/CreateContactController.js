({
	SaveCont : function(component, event, helper) {
        let action = component.get("c.SaveContact");
        var ContactObj = component.get("v.ContactObj");
        action.setParams({
            SaveCon : ContactObj
        });
        action.setCallback(this,function(response){
            let state = response.getState();
           alert(response.getReturnValue());
            if(state ==="SUCCESS"){
               // component.set(ContactObj , SaveCon);
                
                console.log('The field list is :'+JSON.stringify(response.getReturnValue()));
            }else if(state==="ERROR"){
               console.log('Problem saving record, error:' + 
               JSON.stringify(response.error));
               // alert(response.getReturnValue());
            }
            console.log(state);
            
        });
        $A.enqueueAction(action);
    
        component.set("v.ContactObj.FirstName", " ");   
         component.set("v.ContactObj.LastName", " ");   
        component.set("v.ContactObj.Username__c", " ");
        component.set("v.ContactObj.Password__c", " ");
	}
})