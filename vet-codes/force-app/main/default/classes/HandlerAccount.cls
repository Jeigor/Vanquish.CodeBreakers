/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-14-2021
 * @last modified by  : Daniel Boice
**/
public with sharing class HandlerAccount {
    
    /*
    
    Create a trigger on the account object that follows all best practices and implements the following use case:

    Accounts that are associated with an Opportunity that is either "Closed Lost" or "Closed Won" stage should be prevented from deletion. test, test

    */
    public static void handleAccountDeleteValidateOportunitiesNotClosed ( List<Account> acctsToDelete) {
        
        Account[] acctList = [SELECT Id, Name, (SELECT Name, StageName FROM Opportunities WHERE StageName = 'Closed Won' 
                                or StageName = 'Closed Lost'
                                ) FROM Account];

        List<Account> accountWithOpportunityClosedList =new List<Account> ();
        
        for (Account acctInList : acctList) {
            
            List<Opportunity> oplist = (List<Opportunity>) acctInList.Opportunities;
            if (oplist.size()>0){
                accountWithOpportunityClosedList.add(acctInList);
            }    
        }

        for (Account acctToDelete : acctsToDelete) {
            
            if (accountWithOpportunityClosedList.contains(acctToDelete)){
                // throw new System.AssertException('custom message');
                System.debug('custom message');
                acctToDelete.addError('An account with opportunities at the stage of Won or Lost cannot be deleted');
                break;
                

            }
             
        }

        // System.Debug(opportunitiesMatchingClosedList);

        // for ( Account acct : acctsToDelete) {
        //     for(Opportunity opp : opportunitiesMatchingClosedList){
        //         if(opp.Account.Id==acct.Id){
        //             // acct.addError('Whatever message you want here');
        //             // System.Debug(acct.getErrors());
        //             acct.addError('An account with opportunities at the stage of Won or Lost cannot be deleted');
        //         }
        //     }
        // }

       

    }
    // public static void handleAccountAbleToCreateContact ( List<Account> acctsToInsert) {
        
    //     List<Contact> contctList = new List<Contact>();
       
    //     for (Account acct : acctsToInsert){
    //         Contact contct = new Contact ();
    //         contct.Account = acct;
    //         contct.FirstName = 'default first Name';
    //         contct.LastName = 'default Last Name';
    //         contctList.add(contct);
    //     }
    //      // use DML to insert account
    //     Boolean success = true;
	// 	try {
    // 		insert contctList;
    //         System.debug('able to insert contacts for account');
    //     } catch (Exception e) {
    //         System.debug('exception inserting account message: ' + e.getMessage());
    //         System.debug('exception line number: '+ e.getLineNumber());
    //         System.debug('exception stack trace: '+ e.getStackTraceString());
    //     } finally {
    //         System.debug('finally statement executed');
    //     }


    // }
  
    public class InnerException extends System.Exception {
        
        // Here we have defined our own custom exception using an inner class
        // Using an inner class is not required to have a custom exception
        // but it does often happen.
        // We can throw these custom exceptions if we want to
        // Here are some common methods exceptions have:

        // System.debug('something bad happened');
        // getLineNumber() - Returns line number that caused exception to fire
        // getMessage() - Returns the exception message the user can see
        // getStackTraceString() - Returns the stack trace of the exception as a string
        // setMessage() - Sets the exception message the user can see
       
        
    }
    

}