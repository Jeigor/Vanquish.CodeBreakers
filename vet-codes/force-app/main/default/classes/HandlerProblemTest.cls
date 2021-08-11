/**
 * @description       : Tests the Handle Problem After Problem Insert Trigger Handler to send message to Slack developer team
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-11-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-09-2021   Daniel Boice   Initial Version
**/
@IsTest 
public with sharing class HandlerProblemTest {
    @IsTest(SeeAllData=false) public static void sendMessageToDeveloperTeamSlackChannelTest() {
        
        Problem__c myNewProblem = new Problem__c ();
        myNewProblem.Description__c = 'this is a test description';
        myNewProblem.Name = 'problem test';

        List<Problem__c> myProblemList = new List<Problem__c>();
        
        myProblemList.add(myNewProblem);
        Boolean success = true;
            // use DML to update the contacts
		try {
    		insert myNewProblem;
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