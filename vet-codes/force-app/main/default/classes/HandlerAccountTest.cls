/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-10-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-09-2021   Daniel Boice   Initial Version
**/
@IsTest 
public with sharing class HandlerAccountTest {
    @IsTest(SeeAllData=false) public static void handleAccountAbleToCreateContactTest() {
        
        Account myNewAccount = new Account ();
        List<Account> myAccountList = new List<Account>();
        myAccountList.add(myNewAccount);
        Boolean success = true;
            // use DML to update the contacts
		try {
    		HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
            System.debug('able to insert account');
        } 
        catch (Exception e) {
            success = false;
            System.debug(e.getMessage());
            
        } 
        finally {
            System.assertEquals(true, success, 'error inserting account');
        }



    }
}