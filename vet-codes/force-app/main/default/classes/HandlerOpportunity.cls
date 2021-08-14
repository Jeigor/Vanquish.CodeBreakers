/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-14-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-12-2021   Daniel Boice   Initial Version
**/
public with sharing class HandlerOpportunity {
  
    public static void handleAccountDeleteValidateOportunitiesNotClosed ( List<Opportunity> oppsToDelete) {
        
        Account[] acctList = [SELECT Name, (SELECT Name, StageName FROM Opportunities WHERE StageName = 'Closed Won' 
                                or StageName = 'Closed Lost'
                                ) FROM Account];

        List<Account> accountWithOpportunityClosedList =new List<Account> ();
        
        for (Account acct : acctList) {
            for (Opportunity opp:oppsToDelete){
                if (acct.Opportunities.size()>0 && acct.Opportunities.contains(opp)){
                    throw new CustomExceptions.ClosedWonOrLostOpportunitiesExistException(
                        'An account with opportunities at the stage of Won or Lost cannot be deleted');
                    // opp.addError('An account with opportunities at the stage of Won or Lost cannot be deleted')
                }    
            }
            // List<Opportunity> oplist = (List<Opportunity>) acctInList.Opportunities;
            
        }
    }
        // for (Account acctToDelete : acctsToDelete) {
            
        //     if (accountWithOpportunityClosedList.contains(acctToDelete)){
        //         // throw new System.AssertException('custom message');
        //         System.debug('custom message');
        //         acctToDelete.addError('An account with opportunities at the stage of Won or Lost cannot be deleted');
        //         break;
                

        //     }
             
        // }
}
