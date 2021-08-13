/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-12-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-12-2021   Daniel Boice   Initial Version
**/
trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete ) {
  

        switch on trigger.operationType {
            when BEFORE_INSERT {
            
            }
            when BEFORE_UPDATE {
            
            }
            when BEFORE_DELETE {
                // HandlerOpportunity.handleAccountDeleteValidateOportunitiesNotClosed(trigger.old);
            }
            when AFTER_INSERT {
    
            }
            when AFTER_UPDATE {
    
            }
            when AFTER_DELETE {
    
            }
            when AFTER_UNDELETE {
    
            }
        }
    
}