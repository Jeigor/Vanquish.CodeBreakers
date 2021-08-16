/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-16-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-16-2021   Daniel Boice   Initial Version
**/
@isTest(seeAllData=False)
public with sharing class HandlerStandupMeetingTest {
    // public HandlerStandupMeetingTest() {

    // }
        @TestSetup
        static void makeData(){
            List<Coding_session__c> codingSessList = new List<Coding_Session__c>();

            
             
            final String DEVELOPER_TEAM_SAMPLE_NAME = 'test DTN';
            final String PROPBLEM_TEST_NAME = 'problem test NAME';
            final String PROBLEM_TEST_DESC = 'this is a test description';
            final String DEVELOPER_TEAM_DEVELOPER_TEST_NAME = 'Developer Test Name';
    
                
                Developer_Team__c[] devTeamList = new List<Developer_Team__c>();
                
                for(Integer i =0; i<5; i++){
                    Developer_Team__c developerTeamToAdd = new Developer_Team__c();
    
                    developerTeamToAdd.Name = DEVELOPER_TEAM_SAMPLE_NAME +i;
                    devTeamList.add(developerTeamToAdd);

                 }
                boolean success = true;
                String msg = '';
                    // use DML to add developer team sample data
                try {
                    insert devTeamList;
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
    
                Employee__c[] employeeList = new List<Employee__c>();
                
                for(Integer i =0; i<5; i++){
                    Employee__c employeeToAdd = new Employee__c();
                    employeeList.add(employeeToAdd);
                 }
    
                success = true;
                msg = '';
                    // use DML to add developer team sample data
                try {
                    insert employeeList;
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
                Employee__c[] employeeAddedList = [SELECT Id, name FROM Employee__c ];

                System.assertNotEquals(false, employeeAddedList !=null||employeeAddedList.size()!=0||employeeAddedList.size()<4, 'unable to find a sample data for employee employee list size is ' + employeeAddedList.size());
                
 
                Developer_Team__c[] developerTeamAddedList = [SELECT Id, name FROM Developer_Team__c];

              
                System.assertNotEquals(false, developerTeamAddedList!=null||developerTeamAddedList.size()!=0||developerTeamAddedList.size()<4,'unable to find a sample developer team. developerTeamAddedList size is : '+ developerTeamAddedList.size());
                
                
                Developer_Team_Developer__c[] developerTeamDeveloperToAddList = new List<Developer_Team_Developer__c>();
                
                success = true;
                msg ='able to create developer team developer records';
                
                try{

                    for(Integer i =0; i<4; i++){
                        Developer_Team__c devTeam= (Developer_Team__c)developerTeamAddedList[i];
                        Employee__c emp = (Employee__c) employeeAddedList[i];
                        Developer_Team_Developer__c developerTeamDeveloperToAdd = new Developer_Team_Developer__c();
                        developerTeamDeveloperToAdd.Developer_Team__c=devTeam.Id;
                        developerTeamDeveloperToAdd.Developer__c= emp.Id;
                        developerTeamDeveloperToAdd.Name = DEVELOPER_TEAM_DEVELOPER_TEST_NAME+i;
                        developerTeamDeveloperToAddList.add(developerTeamDeveloperToAdd);
                    }

                }
                catch (Exception e){
                    msg='error creating developer team developer list sample data. ' + e.getMessage();
                    success = false;
                }
                
                System.assertEquals(true, success, msg);
    
                success = true;
                msg = 'able to insert test developer team developer';
                    // use DML to add developer team sample data
                try {
                    insert developerTeamDeveloperToAddList;
                    System.debug(msg);
                } 
                catch (Exception e) {
                    msg = e.getMessage()+ ' '+ e.getLineNumber();
                    success = false;
                    System.debug(msg);
                    
                } 
                finally {
                    System.assertEquals(true, success, 'error inserting sample developer team developer records'  + msg);
                }
    
                Developer_Team_Developer__c[] developerTeamDeveloperAddedList = [SELECT Id, Name FROM Developer_Team_Developer__c ];
                
                System.assertNotEquals(false, developerTeamDeveloperAddedList !=null||developerTeamDeveloperAddedList.size()!=0||developerTeamDeveloperAddedList.size() < 5, 'unable to find an sample developer team developer. developerTeamDeveloperAddedList size is '+ developerTeamDeveloperAddedList.size());
                Coding_Session__c[] codingSessionToAddList = new List<Coding_Session__c>();
                success = true;
                msg ='able to create coding sessions';
                try{
                    for(Integer i =0; i<4; i++){
                        Coding_Session__c codingSessionToAdd = new Coding_Session__c();
                        Developer_Team_Developer__c developerTeamDeveloperAdded = (Developer_Team_Developer__c) developerTeamDeveloperAddedList[i];
                        codingSessionToAdd.Developer_Team_Developer__c = developerTeamDeveloperAdded.Id;
                        codingSessionToAdd.Start_Time__c = Datetime.now().addHours(-(i+1));
                        if(math.mod(i, 2)==0){
                            codingSessionToAdd.End_Time__c=Datetime.now();
                        }
                        codingSessionToAddList.add(codingSessionToAdd);
                    }
                }
                catch (Exception e){
                    msg= e.getMessage()+ e.getLineNumber()+e.getStackTraceString();
                    // System.debug(e.getMessage());
                    success = false;
                }
                System.assertEquals(true, success, msg + 'error creating coding session list sample data. DeveloperTeamDeveloperAddedList size is '+ developerTeamDeveloperAddedList.size());
    
                success = true;
                msg = 'able to insert test coding session';
                    // use DML to add developer team sample data
                try {
                    insert codingSessionToAddList;
                } 
                catch (Exception e) {
                    msg = e.getMessage()+ ' '+ e.getLineNumber();
                    success = false;
                } 
                finally {
                    System.assertEquals(true, success, 'error inserting sample coding session'  + msg);
                }
                Coding_Session__c[] codingSessionsAddedList =  [SELECT Id, Name FROM Coding_Session__c ];
                System.assertNotEquals(false, codingSessionsAddedList !=null||codingSessionsAddedList.size()!=0, 'unable to find an sample coding sessions');   
        }
        @isTest
        public static void TP_addStandupToUnassignedCodingSessions(){
            //test create a standup_meeting and assign unassigned coding sessions
            Standup_Meeting__c[] standUpMeetingList = new List<Standup_Meeting__c>();    
            Boolean success = true;
            Datetime earliestDateTimeAdded = Datetime.now();
         
            //create three standup meetings. the first one should be assigned all unassigned coding sessions when inserted.
            try{
                for(Integer i =0; i<4; i++){
                    Standup_Meeting__c standupMeetingToAdd = new Standup_Meeting__c();
                    standupMeetingToAdd.Meeting_Date__c = earliestDateTimeAdded.addDays(i);
                    standupMeetingToAdd.Name = standupMeetingToAdd.Meeting_Date__c.format();
                    standUpMeetingList.add(standupMeetingToAdd);
                }
            }
            catch (Exception e){
                success = false;
            }
            System.assertEquals(true, success, 'error creating standup meeting sample data');
            success = true;
            String msg = 'able to insert test coding session';
                // use DML to add developer team sample data
            try {
                insert standUpMeetingList;
                // System.debug(msg);
            }
            catch (DmlException e) {
                success = false;
                msg = e.getMessage();
                if (msg.contains(CustomExceptions.ERROR_MESSAGE_LINKING_CODING_SESSION_WHEN_INSERTING_STANDUP)){
                    msg=msg+ 'custom error message shown for unable to update coding sessions, but test failed bc was intending to update the coding sessions.';
                }
                else{
                    msg=msg+ 'Account DmlException exeption was caught, and custom error message not displayed';
                    success = false;
                }
            } 
            catch (Exception e) {
                msg = e.getMessage()+ ' '+ e.getLineNumber()+'System.Exception caught.';
                success = false;
            } 
            finally {
                System.assertEquals(true, success, 'error inserting sample coding session'  + msg);
            }

            //get a list of the coding sessions
            Coding_Session__c[] codingSessionsAddedList =  [SELECT Id, Name, Standup_Meeting__c FROM Coding_Session__c];
            
            //there should be a standup meeting returned with the earliest meeting time set from above
            Standup_Meeting__c earliestStandupAdded =(Standup_Meeting__c) [SELECT Meeting_Date__c, Id, Name FROM Standup_Meeting__c WHERE Meeting_Date__c =: earliestDateTimeAdded LIMIT 1];

            //there should be some coding sessions returned
            System.assertNotEquals(false, codingSessionsAddedList !=null||codingSessionsAddedList.size()!=0, 'able to find coding sessions after insert without meeting after inserting a Standup Meeting.');

            
            for (Coding_Session__c codeSess : codingSessionsAddedList){
                //they should all have a meeting date set
                System.assertNotEquals(false, codeSess.Standup_Meeting__c!=null,'there are coding sessions without Standup meetings assigned. codeSess.Standup_Meeting__c==' +codeSess.Standup_Meeting__c);
                //
                System.assertEquals(codeSess.Standup_Meeting__c, earliestStandupAdded.Id, 'there are coding sessions that are not set to the earliest Standup meeting datetime.');
            }



        
    } 
}
