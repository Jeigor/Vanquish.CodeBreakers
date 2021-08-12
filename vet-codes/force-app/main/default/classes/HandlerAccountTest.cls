/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-12-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-09-2021   Daniel Boice   Initial Version
**/
@IsTest 
public with sharing class HandlerAccountTest {

    @TestSetup
    static void createSampleData(){

        Account[] acctList = new List<Account>();
        Opportunity[] oppList = new List<Opportunity>();
        for (Integer i =0; i<3 ; i++) {
        
            Account acctToAdd = new Account ();
            acctToAdd.Name = 'test Account '+i;
            acctList.add(acctToAdd);
            
        }

        
            
           
        //insert the account sample data
        boolean success = true;
        
        try {
            insert acctList;
            //HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
            System.debug('able to insert account list');
            
        } 
        catch (System.DmlException e) {
            //ableToDelete = false;
            System.debug(e.getMessage());
            success = false;
        } 
        finally {
            //System.assertEquals(false, ableToDelete, 'exception');
            System.assertEquals(true, success, 'not able to add sample accounts');
        }

       // Account acctAfterAdd = (Account)[SELECT Name FROM Account WHERE Name =:acctToAdd.Na];

        //     System.debug('test account '+ i+ ' id is '+ acctAfterAdd.Id);
        //     System.debug('test account '+ i +' name after add is '+ acctAfterAdd.Name);
        Account[] acctAfterAdd = [SELECT Name FROM Account WHERE Name LIKE 'test Account%'];
        Integer i=0;
        for(Account acctAdded : acctAfterAdd){
            i++;
            Opportunity oppToAdd = new Opportunity ();
            oppToAdd.Name = 'test Opportunity ' +i;
            oppToAdd.StageName ='Closed Won';
            oppToAdd.AccountId=acctAdded.Id;
            oppToAdd.CloseDate = System.Date.today();
           
            oppList.add(oppToAdd);

        }
        
        success= true;
        //insert the Opportunity sample data
        
        try {
            insert oppList;
            //insert oppToAdd;
            //HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
            System.debug('able to insert opportunities sample data');
        
        } 
        catch (System.DmlException e) {
            //ableToDelete = false;
            System.debug(e.getMessage());
            success = false;
        } 
        finally {
            //System.assertEquals(false, ableToDelete, 'exception');
            System.assertEquals(true, success, 'not able to add opportunity sample data');
        }
        // Opportunity oppAfterAdd = (Opportunity)[SELECT Name, StageName FROM 
        // Opportunity WHERE Name = 'test Opportunity' LIMIT 1];
        // System.debug('account id is '+ oppAfterAdd.Id);
        // System.debug('account name after add is '+ oppAfterAdd.Name);
    }
    // @IsTest(SeeAllData=false) public static Account ableToAddAccountTest() {
        
        
    //     //Opportunity opp = (Opportunity) opportunitiesMatchingClosedList[0];
    //     Account acctToAdd = new Account ();
    //     acctToAdd.Name = 'test Account';
    //     Boolean ableToAdd = true;
    //     System.debug('testing add account');
    //     try {
    //         insert acctToAdd;
    // 		//HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
    //         System.debug('able to insert account');
           
    //     } 
    //     catch (Exception e) {
    //         //ableToDelete = false;
    //         System.debug(e.getMessage());
    //         ableToAdd = false;
    //     } 
    //     finally {
    //         //System.assertEquals(false, ableToDelete, 'exception');
    //         System.assertEquals(true, ableToAdd, 'not able to add account');
    //     }
        
    //     Account acctAfterAdd = (Account)[SELECT Name FROM Account WHERE Name = 'test Account' LIMIT 1][0];



    //     System.debug('account id is '+ acctAfterAdd.Id);
    //     System.debug('account name after add is '+ acctAfterAdd.Name);
    //     if(ableToAdd){

    //         return acctAfterAdd;
    //     }
    //     else{
    //         throw new Exception('unable to add account');
    //     }

    // }
    // @IsTest(SeeAllData=false) public static Opportunity ableToAddOpportunityTest() {
        
    //     Account acctAfterAdd = (Account) ableToAddAccountTest();
    //     Opportunity oppToAdd = new Opportunity ();
    //     oppToAdd.Name = 'test Opportunity';
    //     oppToAdd.StageName ='Closed Won';
    //     oppToAdd.AccountId = acctAfterAdd.Id;
	// 	oppToAdd.CloseDate = System.Date.today();
    //     Boolean ableToAdd = true;
    //     System.debug('testing add opportunity');
	// 	insert oppToAdd;
    //     try {
    //         //insert oppToAdd;
    // 		//HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
    //         System.debug('able to insert opportunity');
           
    //     } 
    //     catch (Exception e) {
    //         //ableToDelete = false;
    //         System.debug(e.getMessage());
    //         ableToAdd = false;
    //     } 
    //     finally {
    //         //System.assertEquals(false, ableToDelete, 'exception');
    //         System.assertEquals(true, ableToAdd, 'not able to add opportunity');
    //     }
        
    //     Opportunity oppAfterAdd = (Opportunity)[SELECT Name, StageName FROM Opportunity WHERE Name = 'test Opportunity' LIMIT 1][0];



    //     System.debug('account id is '+ oppAfterAdd.Id);
    //     System.debug('account name after add is '+ oppAfterAdd.Name);
    //     if(ableToAdd){

    //         return oppAfterAdd;
    //     }
    //     else{
    //         throw new Exception('unable to add account');
    //     }

    // }
    @IsTest(SeeAllData=false) public static void handleAccountAbleToDeleteContactTest() {
        
        // Account acct = (Account) handleAccountAbleToAddAccount();

        // Opportunity opportunitiesMatchingClosedList = (Opportunity)[SELECT Account.Name, StageName 
        //                                                 FROM Opportunity WHERE StageName='Closed Won'
        //                                                  or StageName = 'Closed Lost' LIMIT 1];
        
        Test.startTest();
        Account[] acctList = [SELECT Name, (SELECT Name, StageName FROM Opportunities WHERE StageName = 'Closed Won' 
                                or StageName = 'Closed Lost'
                                ) FROM Account WHERE Name LIKE 'test Account%'];

        List<Account> accountWithOpportunityClosedList =new List<Account> ();
        for (Account acctInList : acctList) {
            List<Opportunity> oplist = (List<Opportunity>) acctInList.Opportunities;
            if (oplist.size()>0){
                accountWithOpportunityClosedList.add(acctInList);
                break;
            }    
        }
        Account acctWithClosedOp;
        System.assertEquals(accountWithOpportunityClosedList.size()==1, accountWithOpportunityClosedList.size()==1,'unable to find an account sample data');
            try {
                acctWithClosedOp = (Account) accountWithOpportunityClosedList[0];
            }
            catch (Exception e) {
                System.assert(false, 'problem assigning account from sample data list size '+accountWithOpportunityClosedList.size());
                System.debug(e.getLineNumber());
                System.debug(e.getMessage());
            } 

            
        boolean tPass=true;
        String msg ='The account was not able to be deleted due to related Closed Opportunities';
        // use DML to test deleting the account
		try {
            if (acctWithClosedOp!=null){
                delete acctWithClosedOp;
                msg='able to insert account with related Closed Opportunities';
    		    //HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
               
                tPass =false;
            }
            else{
                msg= 'no account sample data to test';
                tPass = false;
            }
        } 
        catch(System.AssertException e){

            tPass = false;
            msg = e.getMessage();
            System.debug(e.getLineNumber());
            System.debug(msg);
            if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
                System.debug(msg);
                tPass = true;
            }
            else{
                msg=msg+ 'System.AssertException was thrown, but custom error message not displayed. Check with Caroline how to override if thrown before trigger';
                System.debug(msg);
                tPass = false;
            }


        }
        catch (System.DmlException e) {
            //ableToDelete = false;
           
            tPass = false;
            msg = e.getMessage();
            System.debug(e.getLineNumber());
            System.debug(msg);
            if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
                System.debug(msg);
                tPass = true;
            }
            else{
                msg=msg+ 'Account DmlException exeption was caught, but custom error message not displayed';
                System.debug(msg);
                tPass = false;
            }
        } 
        catch (Exception e) {
            msg=e.getMessage();
            // System.assert(e.getMessage().contains('An account with opportunities at the stage of Won or Lost cannot be deleted'));
            if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
                System.debug(msg);
                tPass = true;
            }
            else{
                msg='Account system System.Exeption was caught, but custom error message not displayed';
                System.debug(msg);
                tPass = false;
            }
            
        } 
        finally {
            System.debug(msg);
            System.assertEquals(true, tPass, msg);

        }
        Test.stopTest();


    }
}