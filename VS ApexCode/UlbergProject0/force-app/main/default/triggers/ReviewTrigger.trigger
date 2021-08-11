trigger ReviewTrigger on Rating__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on trigger.operationType{
        when BEFORE_INSERT {
               // TriggerHandler.Validation(trigger.new);
        }
        when BEFORE_UPDATE{
        TriggerHandler.Validation(trigger.new);
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
            
        }
        when AFTER_UPDATE{
            TriggerHandler.ChangeReview(trigger.new);
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
    
}