/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-15-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-14-2021   Daniel Boice   Initial Version
**/
@isTest(seeAllData=false)
public with sharing class HandlerCodingSessionProblemTest {
    // public HandlerCodingSessionProblemTest() {

    // }

     /*
     Tests updating of the Developer team to send a slack Slack notification.  Will change this to a workflow or Process, shortly, just a demonstration and practice of SOQL, Triggers, Exceptions, and Tests using best practices from week 2 
    */

   

    @TestSetup
    static void createSampleData(){

        //We need to create sample data for Developer Team, Coding Session, Coding Session Problem (Junction Table), and Problem
            
        //need to test bulkification, 
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
            
            
            Problem__c problemToAdd = new Problem__c ();
            problemToAdd.Description__c = PROBLEM_TEST_DESC;
            problemToAdd.Name = PROPBLEM_TEST_NAME;

            success = true;
            msg = 'able to insert test sample problem';
                // use DML to add developer team sample data
        	try {
        		insert problemToAdd;
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
            
            
            

    }
   
   
    @IsTest(SeeAllData=false) public static void TP_sendMessageToDeveloperTeamSlackChannelTest() {
        
        
        //test trigger handler creating a new coding session problem updating the developer team send slack message field in the developer team object
        
        Test.startTest();


        //get a sample problem
        Problem__c sampleProblem = (Problem__c ) [SELECT Id, Name FROM Problem__c LIMIT 1];

        //get a sample coding session
        Coding_Session__c sampleCodingSessionAndDevTeam = (Coding_Session__c) [SELECT Id, Name, Developer_Team_Developer__r.Developer_Team__r.Send_Slack_Message__c FROM Coding_Session__c LIMIT 1];

        // Send message to slack field of sample Developer_Team record should be empty
        System.assertEquals(null, sampleCodingSessionAndDevTeam.Developer_Team_Developer__r.Developer_Team__r.Send_Slack_Message__c, 'developer team slack message field should be null at start');


        Coding_Session_Problem__c codingSessionProblemToAdd = new Coding_Session_Problem__c();
        codingSessionProblemToAdd.Coding_Session__c = sampleCodingSessionAndDevTeam.Id;
        codingSessionProblemToAdd.Problem__c = sampleProblem.Id;

        //test what happens when insert
           Boolean success = true;
           String msg = 'able to insert test sample coding session problem';
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


            //now lets check to see if the developer team send slack message field has updated

            Coding_Session_Problem__c codingSessionProblemAdded = (Coding_Session_Problem__c) [SELECT Id, Name, Coding_Session__c FROM Coding_Session_Problem__c LIMIT 1];
            System.assertNotEquals(codingSessionProblemAdded, null, 'unable to find an sample coding session problem');

            Coding_Session__c codeSess = (Coding_Session__c) [SELECT Id, Name, Developer_Team_Developer__c FROM Coding_Session__c WHERE Id =: codingSessionProblemAdded.Coding_Session__c LIMIT 1];
            //we have the coding session problem that we just entered now lets get the developer team
            // Coding_Session__c sampleCodingSes = (Coding_Session__c) codingSessionProblemAdded.Coding_Session__r;

            Developer_Team_Developer__c devTeamDev = (Developer_Team_Developer__c)[SELECT Name, Id, Developer_Team__c FROM Developer_Team_Developer__c WHERE ID =: codeSess.Developer_Team_Developer__r.Id LIMIT 1];

            Developer_Team__c devTeam = (Developer_Team__c)[SELECT Id, Name, Send_Slack_Message__c FROM Developer_Team__c WHERE id =: devTeamDev.Developer_Team__c LIMIT 1]; 

          

            // check that send to slack message in developer team record is as expected
            System.assertEquals(devTeam.Send_Slack_Message__c, ' New Slack Message: This is one lovely slack message for the '  +  devTeam.Name + ' on the Slack Channel '+ devTeam.Slack_Channel__c + ' as follows: ' + sampleProblem.Description__c);
      

    }

}
