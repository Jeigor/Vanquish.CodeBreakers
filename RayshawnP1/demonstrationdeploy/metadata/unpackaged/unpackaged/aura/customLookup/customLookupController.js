({
   onfocus : function(component,event,helper){
       $A.util.addClass(component.find("mySpinner"), "slds-show");
        var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 10 Records order by createdDate DESC  
         var getInputkeyWord = '';
         helper.searchHelper(component,event,getInputkeyWord);
    },
    onblur : function(component,event,helper){       
        component.set("v.listOfSearchRecords", null );
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    keyPressController : function(component, event, helper) {
       // get the search Input keyword   
         var getInputkeyWord = component.get("v.SearchKeyWord");
       // check if getInputKeyWord size id more then 0 then open the lookup result List and 
       // call the helper 
       // else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
             var forOpen = component.find("searchRes");
               $A.util.addClass(forOpen, 'slds-is-open');
               $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        /*
        else{  
             component.set("v.listOfSearchRecords", null ); 
             var forclose = component.find("searchRes");
               $A.util.addClass(forclose, 'slds-is-close');
               $A.util.removeClass(forclose, 'slds-is-open');
          }
          */
	},
    
  // function for clear the Record Selaction 
    clear :function(component, event, helper){
        
        var name = event.getParam("item").name;
        console.log( "pill removed : "+name);
        //alert(name + ' pill was removed!');
        // Remove the pill from view
        var emplRecs = component.get('v.employeeRecords');
        
        
        
       var items = component.get('v.selectedRecords');
       var item = event.getParam("index");
       items.splice(item, 1);
        emplRecs.splice(item,1)
    	component.set('v.selectedRecords', items);
        component.set('v.employeeRecords', emplRecs);
        console.log(items);
     
        var pillTarget = component.find("lookup-pill");
         var lookUpTarget = component.find("lookupField"); 
       //var selRecs=component.get('v.selectedRecords');
        
      
         $A.util.addClass(pillTarget, 'slds-hide');
         $A.util.removeClass(pillTarget, 'slds-show');
        
         $A.util.addClass(lookUpTarget, 'slds-show');
         $A.util.removeClass(lookUpTarget, 'slds-hide');
      /*
         component.set("v.SearchKeyWord",null);
         component.set("v.listOfSearchRecords", null );
         component.set("v.selectedRecord", {} );  
        component.set("v.selectedRecords",[] );
    */
    },
    
  // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
    // get the selected Account record from the COMPONETN event 	 
       var selectedEmployeeGetFromEvent = event.getParam("recordByEvent");
	   //component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
      
      
      
        
        var selRecs = component.get('v.selectedRecords');
        var selRecContainerInfo = {type: 'avatar', name:selectedEmployeeGetFromEvent.Name , label: selectedEmployeeGetFromEvent.Full_Name__c, fallbackIconName: 'standard:user', variant: 'circle'};
        
        
       //	selRecs.forEach(selr => {
			//console.log(selr['name']);
           // console.log(selr['name']=== selectedEmployeeGetFromEvent.Name);
		//});
            
        let addToSelected = true;  
        selRecs.every(v => {
  			if (v['name']=== selectedEmployeeGetFromEvent.Name) {
    			console.log(v['name']);
            	addToSelected = false;
 			 }
			 console.log(v);
        
  			// Make sure you return true. If you don't return a value, `every()` will stop.
  			return addToSelected;
		});

    if (addToSelected){
  
      	console.log('adding to selected');
       
        	selRecs.push(selRecContainerInfo);
        	component.set("v.selectedRecords", selRecs);
    		component.set("v.listOfSearchRecords", null);
        	//var employeeRecList = component.get('v.employeeRecords');
        	//employeeRecList.push(selectedEmployeeGetFromEvent);
        	//component.set("v.employeeRecords", employeeRecList);
}
         
        /*
        var forclose = component.find("lookup-pill");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
  	*/
        var forclose = component.find("searchRes");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        /*
        var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');  
      */
	},
    handleItemRemove: function (cmp, event) {
        var name = event.getParam("item").name;
        alert(name + ' pill was removed!');
        // Remove the pill from view
        var items = cmp.get('v.items');
        var item = event.getParam("index");
        items.splice(item, 1);
        cmp.set('v.items', items);
    }
})