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
public with sharing class HandlerCodingSessionProblem {
    // public HandlerCodingSessionProblem() {

    // }

    public static void sendSlackMessageToDeveloperTeam(Coding_Session_Problem__c[] codingSessionProbsEnteredL){

        
        
        
        
        // Coding_Session_Problem__c[] myProbSessionList = [SELECT Coding_Session_Problem__c.Problem__r.Id, Coding_Session_Problem__c.Coding_Session__r.Id FROM Coding_Session_Problem__c WHERE Coding_Session_Problem__c.Problem__r.Id =: myProb.Id LIMIT 1];


        // Coding_Session_Problem__c myProblemSession = (Coding_Session_Problem__c) myProbSessionList[0];
        
        
        //make a list of the coding Session Probs Entered coding sessions

        List<Coding_Session__c> codingSessionsInCSPEntered = new List<Coding_Session__c> ();
        List<Problem__c> probList = new List<Problem__c>();
        for (Coding_Session_Problem__c codingSessProb : codingSessionProbsEnteredL){
            //coding session is required field in master detail
            codingSessionsInCSPEntered.add(codingSessProb.Coding_Session__r);
            probList.add(codingSessProb.Problem__r);
        }

        // Problem__c myProblemList = [SELECT Id, Name FROM Problem__c WHERE Id IN : probList];

        List<Coding_Session__c> myCodingSessionDeveloperTeam =[SELECT id, Coding_Session__c.Developer_Team_Developer__r.Developer_Team__r.Slack_Channel__c, Coding_Session__c.Developer_Team_Developer__r.Developer_Team__r.Name, Coding_Session__c.Developer_Team_Developer__r.Developer_Team__r.Send_Slack_Message__c, name FROM Coding_Session__c WHERE Id IN : codingSessionsInCSPEntered];

        List<Developer_Team__c> devTeamsList = new List<Developer_Team__c>();
        for (Coding_Session__c codSess : myCodingSessionDeveloperTeam ){
            devTeamsList.add(codSess.Developer_Team_Developer__r.Developer_Team__r);

        }


        for (Problem__c myProb : probList) {
            for(Developer_Team__c dt : devTeamsList ){
                dt.Send_Slack_Message__c = ' New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + myProb.Description__c; 
            }
        }
       
        // System.debug(dt.Name);
        // System.debug(dt.Send_Slack_Message__c);
        try {
            update devTeamsList;
        }
        catch(DmlException e) {
                e.setMessage(CustomExceptions.ERROR_MESSAGE_UNABLE_TO_UPDATE_DEV_TEAM_SLACK_MESS);
               System.debug('An unexpected error has occurred: ' + e.getMessage());
         }
    }
}
