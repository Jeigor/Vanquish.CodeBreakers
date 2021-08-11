trigger CreateReview on Previously_Sold_Item__c (before insert, before update, before delete, after insert, after update, after delete, after undelete ) {

    switch on trigger.operationType{
        when BEFORE_INSERT{
            
        }
        when BEFORE_UPDATE{
            
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
           // TriggerHandler.createReview(trigger.new) ;
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
    
}