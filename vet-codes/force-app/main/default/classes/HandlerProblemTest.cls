/**
 * @description       : Tests the Handle Problem to prevent delete if the problem is linked to a coding session
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-18-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-09-2021   Daniel Boice   Initial Version
**/
@isTest(seeAllData=false) 
public with sharing class HandlerProblemTest {
    /*
    TP_CheckThatNoCodingSessionsHaveThisProblemBeforeDelete();
    // tests that a problem cannot be deleted if it has child records in the Coding_Session_Problem__c linked to Coding_Session__c and that it displays a custom error message after throwing an error. 

    TN_CheckThatNoCodingSessionsHaveThisProblemBeforeDelete();
    // tests that a problem can be deleted if it does not have child records in the Coding_Session_Problem__c linked to a Coding_Session__c 
    */

    @TestSetup
    static void createSampleData(){
        final String DEVELOPER_TEAM_SAMPLE_NAME = 'test DTN';
        final String PROPBLEM_TEST_NAME = 'problem test NAME';
        final String PROBLEM_TEST_DESC = 'this is a test description';
        final String DEVELOPER_TEAM_DEVELOPER_TEST_NAME = 'Developer Test Name';

            Developer_Team__c developerTeamToAdd = new Developer_Team__c();

            developerTeamToAdd.Name = DEVELOPER_TEAM_SAMPLE_NAME;
    
            Boolean success = true;
            String msg = '';
                // use DML to add developer team sample data
        	try {
        		insert developerTeamToAdd;
                System.debug('able to insert test developer team');
            } 
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber();
                success = false;
                System.debug(msg);
                
            } 
            finally {
                System.assertEquals(true, success, 'error inserting sample developer team'  + msg);
            }

           
            
            
            Employee__c employeeToAdd = new Employee__c();

            success = true;
            msg = '';
                // use DML to add developer team sample data
        	try {
        		insert employeeToAdd;
                System.debug('able to insert test employee');
            } 
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber();
                success = false;
                System.debug(msg);
                
            } 
            finally {
                System.assertEquals(true, success, 'error inserting sample employee'  + msg);
            }
            Employee__c employeeAdded = (Employee__c )[SELECT Id, name FROM Employee__c LIMIT 1];
            System.assertNotEquals(employeeAdded, null, 'unable to find an account sample employee');
            
            
            Developer_Team_Developer__c developerTeamDeveloperToAdd = new Developer_Team_Developer__c();
            Developer_Team__c myDeveloperTeamAdded = (Developer_Team__c) [SELECT Id, name FROM Developer_Team__c LIMIT 1];
          
            System.assertNotEquals(null, myDeveloperTeamAdded,'unable to find an account sample developer team');

            developerTeamDeveloperToAdd.Developer_Team__c=myDeveloperTeamAdded.Id;
            developerTeamDeveloperToAdd.Developer__c= employeeAdded.Id;
            developerTeamDeveloperToAdd.Name = DEVELOPER_TEAM_DEVELOPER_TEST_NAME;

            success = true;
            msg = 'able to insert test developer team developer';
                // use DML to add developer team sample data
        	try {
        		insert developerTeamDeveloperToAdd;
                System.debug(msg);
            } 
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber();
                success = false;
                System.debug(msg);
                
            } 
            finally {
                System.assertEquals(true, success, 'error inserting sample developer team developer'  + msg);
            }

            Developer_Team_Developer__c developerTeamDeveloperAdded = (Developer_Team_Developer__c) [SELECT Id, Name FROM Developer_Team_Developer__c LIMIT 1];
            System.assertNotEquals(developerTeamDeveloperAdded, null, 'unable to find an sample developer team developer');


            Coding_Session__c codingSessionToAdd = new Coding_Session__c();
            codingSessionToAdd.Developer_Team_Developer__c=developerTeamDeveloperAdded.Id;
            codingSessionToAdd.Start_Time__c = Datetime.now();
            

            success = true;
            msg = 'able to insert test coding session';
                // use DML to add developer team sample data
        	try {
        		insert codingSessionToAdd;
                System.debug(msg);
            } 
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber();
                success = false;
                System.debug(msg);
                
            } 
            finally {
                System.assertEquals(true, success, 'error inserting sample coding session'  + msg);
            }

            Coding_Session__c codingSessionAdded = (Coding_Session__c) [SELECT Id, Name FROM Coding_Session__c LIMIT 1];
            System.assertNotEquals(codingSessionAdded, null, 'unable to find an sample coding session');
            
            Problem__c[] probsToAddList = new List<Problem__c>();
            for(Integer i=0 ;i<4; i++ ){
                Problem__c problemToAdd = new Problem__c ();
                problemToAdd.Description__c = PROBLEM_TEST_DESC+i;
                problemToAdd.Name = PROPBLEM_TEST_NAME +i;
                probsToAddList.add(problemToAdd);
             }
            success = true;
            msg = 'able to insert test sample problem';
                // use DML to add developer team sample data
        	try {
        		insert probsToAddList;
                System.debug(msg);
            } 
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber();
                success = false;
                System.debug(msg);
                
            } 
            finally {
                System.assertEquals(true, success, 'error inserting sample test problem'  + msg);
            }

            Problem__c problemAdded = (Problem__c ) [SELECT Id, Name FROM Problem__c LIMIT 1];

            System.assertNotEquals(problemAdded, null, 'unable to find an sample problem');
            
            
            Coding_Session_Problem__c codingSessionProblemToAdd = new Coding_Session_Problem__c();
            codingSessionProblemToAdd.Coding_Session__c = codingSessionAdded.Id;
            codingSessionProblemToAdd.Problem__c = problemAdded.Id;
    
            //test what happens when insert
              success = true;
              msg = 'able to insert test sample coding session problem';
                    // use DML to add developer team sample data
                try {
                    insert codingSessionProblemToAdd;
                    System.debug(msg);
                } 
                catch (System.DmlException e) {
                    //ableToDelete = false;
                   
                    success = false;
                    msg = e.getMessage();
                    System.debug(e.getLineNumber());
                    System.debug(msg);
                    if (msg.contains(CustomExceptions.ERROR_MESSAGE_UNABLE_TO_UPDATE_DEV_TEAM_SLACK_MESS)){
                        msg=msg+ 'custom error message shown for unable to add slack message, but was intending to update';
                        System.debug(msg);
                        success = false;
                    }
                    else{
                        msg=msg+ 'Account DmlException exeption was caught, and custom error message not displayed';
                        System.debug(msg);
                        success = false;
                    }
                } 
                catch (Exception e) {
                    msg=e.getMessage();
                    // System.assert(e.getMessage().contains('problem updating the developer team record for slack message.'));
                    if (msg.contains(CustomExceptions.ERROR_MESSAGE_UNABLE_TO_UPDATE_DEV_TEAM_SLACK_MESS)){
                        msg+= 'custom error message shown for unable to update developer team record with slack message, but intending to update.';
                        System.debug(msg);
                        success = false;
                    }
                    else{
                       
                        System.debug(msg);
                        success = false;
                    }
                    
                } 
                finally {
                    System.debug(msg);
                    System.assertEquals(true, success, msg);
        
                }

                

    }
    @isTest
    public static void TP_CheckThatNoCodingSessionsHaveThisProblemBeforeDelete(){

        Problem__c problemToDelete = (Problem__c ) [SELECT Id, Name FROM Problem__c LIMIT 1];
        System.assertNotEquals(problemToDelete, null, 'unable to find an sample problem');
        Boolean success = true;
        String msg = 'able to insert delete sample coding session problem';
            // use DML to add developer team sample data
        try {
            delete problemToDelete;
            System.debug(msg);
        } 
        catch (CustomExceptions.DeletingProblemLinkedToCodingSessionException e) {
            //ableToDelete = false;
            
        
            msg = e.getMessage();
            System.debug(e.getLineNumber());
            System.debug(msg);
            if (msg.contains(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION)){
                msg=msg+ 'custom error message shown for custom exception as expected';
                System.debug(msg);
                success = true;
            }
            else{
                msg=msg+ 'DeletingProblemLinkedToCodingSessionException exeption was caught, however, correct custom error message was not displayed';
                System.debug(msg);
                success = false;
            }
        } 
        catch (System.DmlException e) {
            //ableToDelete = false;
            
            success = false;
            msg = e.getMessage();
            System.debug(e.getLineNumber());
            System.debug(msg);
            if (msg.contains(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION)){
                msg=msg+ 'custom error message shown for DmlException, but was intending to catch custom exception DeletingProblemLinkedToCodingSessionException';
                System.debug(msg);
                //it will put to pass, but not catching custom exception
                success = true;
            }
            else{
                msg=msg+ 'Account DmlException exeption was caught, and custom error message not displayed';
                System.debug(msg);
                success = false;
            }
        } 
        catch (Exception e) {
            success = false;
            msg=e.getMessage()+'System.Exception caught on delete, but was intending catch custom exception.';
            // System.assert(e.getMessage().contains('problem updating the developer team record for slack message.'));
            if (msg.contains(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION)){
                msg+= ' custom error message shown for deleting problem linked to coding session';
                System.debug(msg);
                
            }
            
            
        } 
        finally {
            System.debug(msg);
            System.assertEquals(true, success, msg);

        }
        

    }
    @isTest
    public static void TN_CheckThatNoCodingSessionsHaveThisProblemBeforeDelete(){

        
        Coding_Session_Problem__c[] codeSessProbList =[SELECT Id, Name, Problem__r.Id FROM Coding_Session_Problem__c];

        List<Id> probIdsInCodingSessProbList = new List<Id>();
        for (Coding_Session_Problem__c codSessProb:codeSessProbList){
            probIdsInCodingSessProbList.add(codSessProb.Problem__r.Id);
        }
        //get list of problems that are not linked to any coding sessions
        Problem__c[] sampleProblemList = [SELECT Id, Name FROM Problem__c WHERE Id NOT IN :probIdsInCodingSessProbList];
        Problem__c[] problemListRemoveAnyWithCodingSessProblemsList = new List<Problem__c>();
        
        for(Integer i = (sampleProblemList.size()-1) ; i>= 0 ; i--){
            Problem__c prob =(Problem__c) sampleProblemList[i];
            if (!probIdsInCodingSessProbList.contains(prob.Id)) {
                problemListRemoveAnyWithCodingSessProblemsList.add(prob);
            }

        }

        System.assertNotEquals(true, sampleProblemList ==null || sampleProblemList.size()<1, 'unable to find any sample problems without coding sessions');
        Boolean success = true;
        String msg = 'able to insert delete problem';
        String msgFail = 'not expecting error to be thrown without Problems linked to any Coding_Sessions';
            // use DML to add developer team sample data
        try {
            delete problemListRemoveAnyWithCodingSessProblemsList;
            System.debug(msg);
        } 
        catch (CustomExceptions.DeletingProblemLinkedToCodingSessionException e) {
            //ableToDelete = false;
            
            success = false;
            msg = e.getMessage();
            System.debug(e.getLineNumber());
            System.debug(msg);
            if (msg.contains(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION)){
                msg=msg+ 'custom error message shown for custom exception, ' + msgFail;
                System.debug(msg);
               
            }
            else{
                msg=msg+ 'DeletingProblemLinkedToCodingSessionException exeption was caught, however, incorrect custom error message was displayed, and '+ msgFail;
                System.debug(msg);
                
            }
        } 
        catch (System.DmlException e) {
            //ableToDelete = false;
            
            success = false;
            msg = e.getMessage();
            System.debug(e.getLineNumber());
            System.debug(msg);
            if (msg.contains(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION)){
                msg=msg+ 'custom error message shown for DmlException,' + msgFail+', but was not expecting an error to be thrown for problems without matching Coding_Session_Problems__c';
                System.debug(msg);
                success = false;
            }
            else{
                msg=msg+ 'Account DmlException exeption was caught, custom error message not displayed, and '+msgFail;
                System.debug(msg);
                success = false;
            }
        } 
        catch (Exception e) {
            success = false;
            msg=e.getMessage()+'System.Exception caught on delete, but '+ msgFail;
            // System.assert(e.getMessage().contains('problem updating the developer team record for slack message.'));
            if (msg.contains(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION)){
                msg+= ' custom error message shown for deleting problem linked to coding session';
                System.debug(msg);
                
            }
            
            
        } 
        finally {
            System.debug(msg);
            System.assertEquals(true, success, msg);

        }
    }

//     final String DEVELOPER_TEAM_SAMPLE_NAME = 'test DTN';
//     final String PROPBLEM_TEST_NAME = 'problem test NAME';
//     final String PROBLEM_TEST_DESC = 'this is a test description';
//     final String DEVELOPER_TEAM_DEVELOPER_TEST_NAME = 'Developer Test Name';

//     @TestSetup
//     static void createSampleData(){

//         //We need to create sample data for Developer Team, Coding Session, Coding Session Problem (Junction Table), and Problem
            
//         //need to test bulkification, 

//             Deveoper_Team__c NewDeveloperToAdd = new Developer_Team__c();

//             myNewDeveloperTeam.Name = DEVELOPER_TEAM_SAMPLE_NAME;
    
//             Boolean success = true;
//             String msg = '';
//                 // use DML to add developer team sample data
//         	try {
//         		insert developerTeamToAdd;
//                 System.debug('able to insert test developer team');
//             } 
//             catch (Exception e) {
//                 msg = e.getMessage()+ ' '+ e.getLineNumber();
//                 success = false;
//                 System.debug(msg);
                
//             } 
//             finally {
//                 System.assertEquals(true, success, 'error inserting sample developer team'  + msg);
//             }

//             Deveoper_Team__c developerTeamAdded = (DeveloperDeveloper_Team__c) [SELECT Id, name FROM Developer_Team__c LIMIT 1];
//             System.assertNotEquals(developerTeamAdded, null, 'unable to find an account sample developer team');
            
            
//             Employee__c employeeToAdd = new Employee__c();

//             success = true;
//             msg = '';
//                 // use DML to add developer team sample data
//         	try {
//         		insert employeeToAdd;
//                 System.debug('able to insert test employee');
//             } 
//             catch (Exception e) {
//                 msg = e.getMessage()+ ' '+ e.getLineNumber();
//                 success = false;
//                 System.debug(msg);
                
//             } 
//             finally {
//                 System.assertEquals(true, success, 'error inserting sample employee'  + msg);
//             }
//             Employee__c employeeAdded = (Employee__c )[SELECT Id, name FROM Employee__c LIMIT 1];
//             System.assertNotEquals(employeeAdded, null, 'unable to find an account sample employee');
            
            
//             Developer_Team_Developer__c developerTeamDeveloperToAdd = new Developer_Team_Developer();
//             developerTeamDeveloperToAdd.Developer_Team__c=developerTeamAdded.Id;
//             developerTeamDeveloperToAdd.Developer__c= employeeAdded.Id;
//             developerTeamDeveloperToAdd.Name = DEVELOPER_TEAM_DEVELOPER_TEST_NAME;

//             success = true;
//             msg = 'able to insert test developer team developer';
//                 // use DML to add developer team sample data
//         	try {
//         		insert developerTeamDeveloperToAdd;
//                 System.debug(msg);
//             } 
//             catch (Exception e) {
//                 msg = e.getMessage()+ ' '+ e.getLineNumber();
//                 success = false;
//                 System.debug(msg);
                
//             } 
//             finally {
//                 System.assertEquals(true, success, 'error inserting sample developer team developer'  + msg);
//             }

//             Developer_Team_Developer__c developerTeamDeveloperAdded = (Developer_Team_Developer__c) [SELECT Id, Name FROM Developer_Team_Developer__c LIMIT 1];
//             System.assertNotEquals(developerTeamDeveloperAdded, null, 'unable to find an sample developer team developer');


//             Coding_Session__c codingSessionToAdd = new Coding_Session__c();
//             codingSessionToAdd.DeveloperTeam_Developer__c=developerTeamDeveloperAdded.Id;
//             codingSessionToAdd.Start_Time__c = Datetime.now();
            

//             success = true;
//             msg = 'able to insert test coding session';
//                 // use DML to add developer team sample data
//         	try {
//         		insert codingSessionToAdd;
//                 System.debug(msg);
//             } 
//             catch (Exception e) {
//                 msg = e.getMessage()+ ' '+ e.getLineNumber();
//                 success = false;
//                 System.debug(msg);
                
//             } 
//             finally {
//                 System.assertEquals(true, success, 'error inserting sample coding session'  + msg);
//             }

//             Coding_Session__c codingSessionAdded = (DeveloperDeveloper_Team_Developer__c) [SELECT Id, Name FROM Coding_Session__c LIMIT 1];
//             System.assertNotEquals(codingSessionAdded, null, 'unable to find an sample coding session');
            
            
//             Problem__c problemToAdd = new Problem__c ();
//             problemToAdd.Description__c = PROBLEM_TEST_DESC;
//             problemToAdd.Name = PROPBLEM_TEST_NAME;

//             success = true;
//             msg = 'able to insert test sample problem';
//                 // use DML to add developer team sample data
//         	try {
//         		insert problemToAdd;
//                 System.debug(msg);
//             } 
//             catch (Exception e) {
//                 msg = e.getMessage()+ ' '+ e.getLineNumber();
//                 success = false;
//                 System.debug(msg);
                
//             } 
//             finally {
//                 System.assertEquals(true, success, 'error inserting sample test problem'  + msg);
//             }

//             Problem__c problemAdded = (Problem__c ) [SELECT Id, Name FROM Problem__c LIMIT 1];

//             System.assertNotEquals(problemAdded, null, 'unable to find an sample problem');
            
            
//             Coding_Session_Problem__c codingSessionProblemToAdd = new Coding_Session_Problem__c();
//             codingSessionProblemToAdd.Session__c = codingSessionAdded.Id;
//             codingSessionProblemToAdd.Problem__c = problemAdded.Id;



//             success = true;
//             msg = 'able to insert test sample coding session problem';
//                 // use DML to add developer team sample data
//         	try {
//         		insert codingSessionProblemToAdd;
//                 System.debug(msg);
//             } 
//             catch (Exception e) {
//                 msg = e.getMessage()+ ' '+ e.getLineNumber();
//                 success = false;
//                 System.debug(msg);
                
//             } 
//             finally {
//                 System.assertEquals(true, success, 'error inserting sample test coding session problem'  + msg);
//             }

//             Coding_Session_Problem__c codingSessionProblemAdded = (Coding_Session_Problem__c) [SELECT Id, Name FROM Coding_Session_Problem__c LIMIT 1];
//             System.assertNotEquals(codingSessionProblemAdded, null, 'unable to find an sample coding session problem');

//     }
   
   
//     @IsTest(SeeAllData=false) public static void TP_sendMessageToDeveloperTeamSlackChannelTest() {
        
//         // Account acct = (Account) handleAccountAbleToAddAccount();

//         // Opportunity opportunitiesMatchingClosedList = (Opportunity)[SELECT Account.Name, StageName 
//         //                                                 FROM Opportunity WHERE StageName='Closed Won'
//         //                                                  or StageName = 'Closed Lost' LIMIT 1];
        
//         Test.startTest();
//         Problem__c probToAdd = new Problem__c ();
//         probToAdd.Description = PROBLEM_TEST_DESC;
//         probToAdd.Name = PROPBLEM_TEST_NAME;


//         Coding_Session__c codingSessionAdded = (DeveloperDeveloper_Team_Developer__c) [SELECT Id, Name FROM Coding_Session__c LIMIT 1];
//         Coding_Session_Problem__c codingSessionProblemToAdd = new Coding_Session_Problem__c();
//             codingSessionProblemToAdd.Session__c = codingSessionAdded.Id;
//             codingSessionProblemToAdd.Problem__c = problemAdded.Id;

//         List<Account> accountWithOpportunityClosedList =new List<Account> ();
//         for (Account acctInList : acctList) {
//             List<Opportunity> oplist = (List<Opportunity>) acctInList.Opportunities;
//             if (oplist.size()>0){
//                 accountWithOpportunityClosedList.add(acctInList);
//                 break;
//             }    
//         }
       
            
//         boolean tPass=true;
//         String msg ='The account was not able to be deleted due to related Closed Opportunities';
//         // use DML to test deleting the account
// 		try {
//             if (acctWithClosedOp!=null){
//                 delete acctWithClosedOp;
//                 msg='able to insert account with related Closed Opportunities';
//     		    //HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
               
//                 tPass =false;
//             }
//             else{
//                 msg= 'no account sample data to test';
//                 tPass = false;
//             }
//         } 
//         catch(CustomExceptions.ClosedWonOrLostOpportunitiesExistException e){

//             tPass = true;
//             msg = e.getMessage();
//             System.debug(e.getLineNumber());
//             System.debug(msg);
//             if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
//                 System.debug(msg);
//                 tPass = true;
//             }
//             else{
//                 msg=msg+ 'CustomException.ClosedWonOrLostOpportunitiesExistException was thrown, but custom error message not displayed. Check with Caroline how to override if thrown before trigger';
//                 System.debug(msg);
//                 tPass = false;
//             }


//         }
//         catch(System.AssertException e){

//             tPass = false;
//             msg = e.getMessage();
//             System.debug(e.getLineNumber());
//             System.debug(msg);
//             if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
//                 System.debug(msg);
//                 tPass = true;
//             }
//             else{
//                 msg=msg+ 'System.AssertException was thrown, but custom error message not displayed. Check with Caroline how to override if thrown before trigger';
//                 System.debug(msg);
//                 tPass = false;
//             }


//         }
//         catch (System.DmlException e) {
//             //ableToDelete = false;
           
//             tPass = false;
//             msg = e.getMessage();
//             System.debug(e.getLineNumber());
//             System.debug(msg);
//             if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
//                 System.debug(msg);
//                 tPass = true;
//             }
//             else{
//                 msg=msg+ 'Account DmlException exeption was caught, but custom error message not displayed';
//                 System.debug(msg);
//                 //This I would like to fail, but not able to override the System.AssertException that is thrown prior to trigger on Account running,
//                 // possibly by a validation rule set somewhere else. 
//                 tPass = true;
//             }
//         } 
//         catch (Exception e) {
//             msg=e.getMessage();
//             // System.assert(e.getMessage().contains('An account with opportunities at the stage of Won or Lost cannot be deleted'));
//             if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
//                 System.debug(msg);
//                 tPass = true;
//             }
//             else{
//                 msg='Account system System.Exeption was caught, but custom error message not displayed';
//                 System.debug(msg);
//                 tPass = false;
//             }
            
//         } 
//         finally {
//             System.debug(msg);
//             System.assertEquals(true, tPass, msg);

//         }
//         Test.stopTest();


//     }

//     @IsTest(SeeAllData=false) public static void TN_handleAccountAbleToDeleteContactTest() {
        
        
//         Test.startTest();
//         Account[] acctList = [SELECT Name, (SELECT Name, StageName FROM Opportunities WHERE (NOT StageName LIKE 'Closed%')
//                                 ) FROM Account WHERE Name LIKE 'test Account%'];

//         //getting account with Prospecting opportunity
//         List<Account> accountWithOpportunityProspectingList =new List<Account> ();
//         for (Account acctInList : acctList) {
//             List<Opportunity> oplist = (List<Opportunity>) acctInList.Opportunities;
//             if (oplist.size()>0){
//                 accountWithOpportunityProspectingList.add(acctInList);
//                 break;
//             }    
//         }
//         Account acctWithProspectingOp;
//         System.assert(accountWithOpportunityProspectingList.size()==1,'unable to find an account sample data with opportunity in prospecting stage');
//             try {
//                 acctWithProspectingOp = (Account) accountWithOpportunityProspectingList[0];
//             }
//             catch (Exception e) {
//                 System.assert(false, 'problem assigning account from sample data list size '+accountWithOpportunityProspectingList.size());
//                 System.debug(e.getLineNumber());
//                 System.debug(e.getMessage());
//             } 

            
//         boolean tPass=true;
//         String msg ='The account was able to be deleted due to related Opportunities in Prospecting Stage';
//         // use DML to test deleting the account
// 		try {
//             if (acctWithProspectingOp!=null){
//                 delete acctWithProspectingOp;
//                 msg='able to delete account with related Opportunities in Prospecting Stage';
//     		    //HandlerAccount.handleAccountAbleToCreateContact(myAccountList);
               
//                 tPass =true;
//             }
//             else{
//                 msg= 'Account sample data not present.';
//                 tPass = false;
//             }
//         } 
       
//         catch (System.DmlException e) {
//             //ableToDelete = false;
           
//             tPass = false;
//             msg = e.getMessage();
//             System.debug(e.getLineNumber());
//             System.debug(msg);
//             if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
//                 msg=msg+ 'custom error message shown for deleting with Closed Lost or Won, but was not supposed to display for Prospecting.';
//                 System.debug(msg);
//                 tPass = false;
//             }
//             else{
//                 msg=msg+ 'Account DmlException exeption was caught, and custom error message not displayed';
//                 System.debug(msg);
//                 tPass = false;
//             }
//         } 
//         catch (Exception e) {
//             msg=e.getMessage();
//             // System.assert(e.getMessage().contains('An account with opportunities at the stage of Won or Lost cannot be deleted'));
//             if (msg.contains('An account with opportunities at the stage of Won or Lost cannot be deleted')){
//                 msg+= 'custom error message shown for accounts deleted with Closed Won or Lost, but should not display when Prospecting stage is deleted.';
//                 System.debug(msg);
//                 tPass = false;
//             }
//             else{
               
//                 System.debug(msg);
//                 tPass = false;
//             }
            
//         } 
//         finally {
//             System.debug(msg);
//             System.assertEquals(true, tPass, msg);

//         }
//         Test.stopTest();


//     }


// }



// @IsTest 
// public with sharing class HandlerProblemTest {
//     @IsTest(SeeAllData=false) public static void sendMessageToDeveloperTeamSlackChannelTest() {
        
    //     Problem__c problemToAdd = new Problem__c ();
    //     problemToAdd.Description__c = 'this is a test description';
    //     problemToAdd.Name = 'problem test';

    //     List<Problem__c> myProblemList = new List<Problem__c>();
        
    //     myProblemList.add problemToAdd);
    //     Boolean success = true;
    //         // use DML to update the contacts
	// 	try {
    // 		insert problemToAdd;
    //         System.debug('able to insert account');
    //     } 
    //     catch (Exception e) {
    //         success = false;
    //         System.debug(e.getMessage());
            
    //     } 
    //     finally {
    //         System.assertEquals(true, success, 'error inserting account');
    //     }



    // }
}