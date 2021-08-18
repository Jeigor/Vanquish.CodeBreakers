/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-18-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-14-2021   Daniel Boice   Initial Version
**/
public with sharing class HandlerCodingSessionProblem {
    // public HandlerCodingSessionProblem() {

    // }

    public static void sendSlackMessageToDeveloperTeam(Coding_Session_Problem__c[] codingSessionProbsEnteredL){

        
        
        
        
        // Coding_Session_Problem__c[] myProbSessionList = [SELECT Coding_Session_Problem__c.Problem__r.Id, Coding_Session_Problem__c.Coding_Session__r.Id FROM Coding_Session_Problem__c WHERE Coding_Session_Problem__c.Problem__r.Id =: myProb.Id LIMIT 1];


        // Coding_Session_Problem__c myProblemSession = (Coding_Session_Problem__c) myProbSessionList[0];
        
        
        //make a list of the coding Session Probs Entered coding sessions

        List<Id> codingSessionsInCSPIDList = new List<Id> ();
        List<Id> probIdList = new List<Id>();
        for (Coding_Session_Problem__c codingSessProb : codingSessionProbsEnteredL){
            //coding session is required field in master detail
            codingSessionsInCSPIdList.add(codingSessProb.Coding_Session__c);
            probIdList.add(codingSessProb.Problem__c);
        }

        Problem__c[] probList = [SELECT Id, Name, Description__c FROM Problem__c WHERE Id IN : probIdList];

        List<Coding_Session__c> codingSessionList = [SELECT Id,  Developer_Team_Developer__c, name FROM Coding_Session__c WHERE Id IN : codingSessionsInCSPIdList];

        List<Id> devTeamDevIDList = new List<Id>();
        
        for (Coding_Session__c codSess : codingSessionList ){
            devTeamDevIDList.add(codSess.Developer_Team_Developer__c);

        }


        Developer_Team_Developer__c[] devTeamDeveloperList =[SELECT Id, Developer_Team__r.Send_Slack_Message__c, Developer_Team__r.Id, Developer_Team__r.Slack_Channel__c FROM Developer_Team_Developer__c WHERE Id IN : devTeamDevIDList];

        // Developer_Team__c[] devTeamList =[SELECT Id, Name, Send_Slack_Message__c, Slack_Channel__c , (SELECT Id FROM Developer_Teams_Developers__r WHERE Id IN : devTeamDevIDList) FROM Developer_Team__c];

        List<Id> devTeamIdList = new List<Id> ();
                                                                                              
        for (Developer_Team_Developer__c dtd :devTeamDeveloperList ){

                devTeamIdList.add(dtd.Developer_Team__r.Id);
        }
        
        Developer_Team__c[] devTeamList =[SELECT Id, Name, Send_Slack_Message__c, Slack_Channel__c FROM Developer_Team__c WHERE Id IN : devTeamIdList];
        System.assertNotEquals(null, devTeamList,'developer team list should not be null or 0');


        List<Developer_Team__c> updatedDeveloperTeamList = new List<Developer_Team__c>();

    
            for(Developer_Team__c dt : devTeamList ){
                    for(Problem__c prob : probList){
                        dt.Send_Slack_Message__c = 'New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + prob.Description__c; 
                        updatedDeveloperTeamList.add(dt);
                    }
            }
    
       System.assertEquals(true, updatedDeveloperTeamList.size()>0, 'updatedDeveloperTeamList size in handlercodingsession is '+ updatedDeveloperTeamList.size()+updatedDeveloperTeamList);
        // System.debug(dt.Name);
        // System.debug(dt.Send_Slack_Message__c);
        try {
            update updatedDeveloperTeamList;
        }
        catch(DmlException e) {
                e.setMessage(CustomExceptions.ERROR_MESSAGE_UNABLE_TO_UPDATE_DEV_TEAM_SLACK_MESS);
               System.debug('An unexpected error has occurred: ' + e.getMessage());
         }
    }
}
