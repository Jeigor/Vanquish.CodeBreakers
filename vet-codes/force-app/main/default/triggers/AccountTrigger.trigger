/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-09-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete ) {

    switch on trigger.operationType {
        when BEFORE_INSERT {
        
        }
        when BEFORE_UPDATE {
        
        }
        when BEFORE_DELETE {
            HandlerAccount.handleAccountValidateOportunitiesNotClosed(trigger.new);
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

//     if (trigger.isBefore){

//         if (trigger.isInsert){

//         }
//         else if(trigger.isUpdate){

//         }
//         else if (trigger.isDelete){

//         }
//     }
//     else if (trigger.isAfter){
//         if(trigger.isInsert){

//         }
//         else if (trigger.isUpdate){

//         }
//         else if (trigger.isDelete){

//         }
//         else if (trigger.isUndelete){

//         }
//     }

}