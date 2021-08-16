/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-16-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-11-2021   Daniel Boice   Initial Version
**/
public with sharing class HandlerProblem {
    
    /*
    
    
     Updates the Developer team to send a slack Slack notification.  Will change this to a workflow or Process, shortly, just a demonstration
    and practice of SOQL, Triggers, Exceptions, and Tests from week 2 

	
	PProblem__c[] myProbList = [SELECT Id, Description__c FROM Problem__c WHERE Id = 'a1V5e000005eG82EAE' LIMIT 1];
	Problem__c myProb = (Problem__c) myProbList[0];
	System.debug(myProb.Id);
	Coding_Session_Problem__c[] myProbSessionList = [SELECT Coding_Session_Problem__c.Problem__r.Id, Coding_Session_Problem__c.Coding_Session__r.Id FROM Coding_Session_Problem__c WHERE Coding_Session_Problem__c.Problem__r.Id =: myProb.Id LIMIT 1];
	Coding_Session_Problem__c myProblemSession = (Coding_Session_Problem__c) myProbSessionList[0];	
    Coding_Session__c myCodingSessionDeveloperTeam =(Coding_Session__c)[SELECT Coding_Session__c.Developer_Team__r.Slack_Channel__c, Coding_Session__c.Developer_Team__r.Name, Coding_Session__c.Developer_Team__r.Send_Slack_Message__c, name From Coding_Session__c WHERE Coding_Session__c.Id =:myProblemSession.Coding_Session__r.Id LIMIT 1][0];
	Developer_Team__c dt = (Developer_Team__c) myCodingSessionDeveloperTeam.Developer_Team__r;
	dt.Send_Slack_Message__c = dt.Send_Slack_Message__c + ' New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + myProb.Description__c); 
	System.debug(dt.Name);
    */

	public static void checkThatNoCodingSessionsHaveThisProblemBeforeDelete ( List<Problem__c> probsToDelete) {

	
        
		//get list of ids for the problems to delete
		List<Id> probToDeleteIdList = new List<Id>();
		for(Problem__c prob : probsToDelete){
			
			probToDeleteIdList.add(prob.Id);
		}

		Coding_Session_Problem__c[] codingSessionProblemsLinkedToProblems = [SELECT Id, Name, Problem__r.Id FROM Coding_Session_Problem__c WHERE Problem__r.Id IN :probToDeleteIdList];

		for (Coding_Session_Problem__c codSessProb :codingSessionProblemsLinkedToProblems){
			if(probToDeleteIdList.contains(codSessProb.Problem__r.Id)){
				throw new CustomExceptions.DeletingProblemLinkedToCodingSessionException(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION);
			}

		}


		// System.assertEquals(0, codingSessionProblemsLinkedToProblems.size(), codingSessionProblemsLinkedToProblems + 'should not have any coding session problems');
		// if(codingSessionProblemsLinkedToProblems.size()>0){
		// 	//there are coding session problems linked to this problem
		// 	throw new CustomExceptions.DeletingProblemLinkedToCodingSessionException(CustomExceptions.ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION);
		// }




	}
    // public static void sendMessageToDeveloperTeamSlackChannel ( List<Problem__c> probsCreated) {

		// need to bulkify this
        
            // Problem__c myProb = probsCreated[0];

            // //Problem__c[] myProbList = [SELECT Id, Description__c FROM Problem__c WHERE Id = 'a1V5e000005eG82EAE' LIMIT 1];
	        // // Problem__c myProb = (Problem__c) myProbList[0];
	        // System.debug(myProb.Id);
			// // Make sure we can update the database before even trying
			// if (!Schema.sObjectType.Developer_Team__c.fields.Slack_Channel__c.isUpdateable()) {
			// 	return;
			// }
	        // Coding_Session_Problem__c[] myProbSessionList = [SELECT Coding_Session_Problem__c.Problem__r.Id, Coding_Session_Problem__c.Coding_Session__r.Id FROM Coding_Session_Problem__c WHERE Coding_Session_Problem__c.Problem__r.Id =: myProb.Id LIMIT 1];
	        // Coding_Session_Problem__c myProblemSession = (Coding_Session_Problem__c) myProbSessionList[0];	
            // Coding_Session__c myCodingSessionDeveloperTeam =(Coding_Session__c)[SELECT Coding_Session__c.Developer_Team_Developer__r.Developer_Team__r.Slack_Channel__c, Coding_Session__c.Developer_Team_Developer__r.Developer_Team__r.Name, Coding_Session__c.Developer_Team_Developer__r.Developer_Team__r.Send_Slack_Message__c, name From Coding_Session__c WHERE Coding_Session__c.Id =:myProblemSession.Coding_Session__r.Id LIMIT 1][0];
	        // Developer_Team__c dt = (Developer_Team__c) myCodingSessionDeveloperTeam.Developer_Team__r;
	        // dt.Send_Slack_Message__c = ' New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + myProb.Description__c; 
	        // System.debug(dt.Name);
	        // System.debug(dt.Send_Slack_Message__c);
            // try {
    	    //     update dt;
	        // }
            // catch(DmlException e) {
   		    //     System.debug('An unexpected error has occurred: ' + e.getMessage());
            //  }
	        //Problem__c myProb = (Problem__c) [SELECT Id, Description__c FROM Problem__c WHERE Id = 'a1V5e000005eG82EAE' LIMIT 1][0];
	       // Problem_Session__c myProbSession = [SELECT Problem_Session_c.Session__r.Id, Problem_Session__c.Problem__r.Id FROM Problem_Session_c WHERE Problem_Session__c.Problem__r.Id =: myProb.Id LIMIT 1][0];

	        //Coding_Session__c myCodingSessionDeveloperTeam =(Coding_Session__c)[SELECT Coding_Session__c.Developer_Team__r.Slack_Channel__c, Coding_Session__c.Developer_Team__r.Name, Coding_Session__c.Developer_Team__r.Send_Slack_Message__c, name From Coding_Session__c WHERE Coding_Session__c.Id =:myProbSession.Coding_Session__r.Id LIMIT 1][0];
	       // Developer_Team__c dt = (Developer_Team__c) myCodingSessionDeveloperTeam.Developer_Team__r;
	        //dt.Send_Slack_Message__c= dt.Send_Slack_Message__c + '\n New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + prob.Description__c); 

	       // System.debug(dt.Send_Slack_Message__c);
        
//Coding_Session__c[] myCodingSessionsWithCildCodingSessionProblems = [SELECT Id, Name, Developer_Team__r.Slack_Channel__c, (SELECT Name, Id FROM Coding_Sessions_Problems__r) FROM Coding_Session__c];
 //Coding_Session__c[] myCodingSessionsWithCildCodingSessionProblems = [SELECT Id, Name, Developer_Team__r.Slack_Channel__c, (SELECT Name, Id, Problem__r.Description__c FROM Coding_Sessions_Problems__r) FROM Coding_Session__c];
//Coding_Session_Problem__c[] myCodingSessionsProblems =[SELECT name , Coding_Session__c, Coding_Session_Problem__c.Problem__r.Description__c FROM Coding_Session_Problem__c];

//for (Coding_Session__c codSess : myCodingSessionsDeveloperTeam){
        //Developer_Team__c dt = (Developer_Team__c) codSess.Developer_Team__r;
    	//System.debug(dt.Name);
        //System.Debug (codSess.Developer_Team__r.Slack_Channel__c);
    	//for (Coding_Session_Problem__c codingSessProb : myCodingSessionsProblems){
            //Problem__c prob = (Problem__c)Coding_Session_Problem__c.Problem__r;
            //if(prob.Id=='a1V5e000005eG82EAE' && codingSessProb.Coding_Session__r.Id==codSess.Id){
                //dt.Send_Slack_Message__c= dt.Send_Slack_Message__c + '\n New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + prob.Description__c); 
                // Use a try catch block to insert the account list
				//try {
    				//update dt;
				//}
      			//catch(DmlException e) {
    				//System.debug('An unexpected error has occurred: ' + e.getMessage());
				//}
           // }
           // System.debug(codingSessProb.Problem__r.Description__c);
		//}
//}
//System.debug(myCodingSessionsDeveloperTeam);
//System.debug('myCodingSessionsWithCildCodingSessionProblems ' + myCodingSessionsWithCildCodingSessionProblems);
//System.debug('myCodingSessionsProblems ' + myCodingSessionsProblems);



//for (Coding_Session_Problem__c codingSessProb : myCodingSessionsProblems){
//    System.debug(codingSessProb.Problem__r.Description__c);
//}

///System.Debug(myCodingSessions);
        
        
//            Problem_Session__c [] myProbSession = [SELECT Problem_Session_c.Session__r.Id, Problem_Session__c.Problem__r.Id FROM Problem_Session_c WHERE Problem_Session__c.Problem__r.Id =: prob.Id];
// Coding_Session__c[] myCodingSessionsDeveloperTeam =[SELECT Coding_Session__c.Developer_Team__r.Slack_Channel__c, Coding_Session__c.Developer_Team__r.Name, Coding_Session__c.Developer_Team__r.Send_Slack_Message__c, name From Coding_Session__c];
// //Coding_Session__c[] myCodingSessionsWithCildCodingSessionProblems = [SELECT Id, Name, Developer_Team__r.Slack_Channel__c, (SELECT Name, Id FROM Coding_Sessions_Problems__r) FROM Coding_Session__c];
//  Coding_Session__c[] myCodingSessionsWithCildCodingSessionProblems = [SELECT Id, Name, Developer_Team__r.Slack_Channel__c, (SELECT Name, Id, Problem__r.Description__c FROM Coding_Sessions_Problems__r) FROM Coding_Session__c];
// Coding_Session_Problem__c[] myCodingSessionsProblems =[SELECT name , Coding_Session__c, Coding_Session_Problem__c.Problem__r.Description__c FROM Coding_Session_Problem__c];

// for (Coding_Session__c codSess : myCodingSessionsDeveloperTeam){
//         Developer_Team__c dt = (Developer_Team__c) codSess.Developer_Team__r;
//     	System.debug(dt.Name);
//         System.Debug (codSess.Developer_Team__r.Slack_Channel__c);
//     	for (Coding_Session_Problem__c codingSessProb : myCodingSessionsProblems){
//             Problem__c prob = (Problem__c)Coding_Session_Problem__c.Problem__r;
//             if(prob.Id=='a1V5e000005eG82EAE' && codingSessProb.Coding_Session__r.Id==codSess.Id){
//                 dt.Send_Slack_Message__c= dt.Send_Slack_Message__c + '\n New Slack Message: This is one lovely slack message for the '  +  dt.Name + ' on the Slack Channel '+ dt.Slack_Channel__c + ' as follows: ' + prob.Description__c); 
//                 // Use a try catch block to insert the account list
// 				try {
//     				update dt;
// 				}
//       			catch(DmlException e) {
//     				System.debug('An unexpected error has occurred: ' + e.getMessage());
// 				}
//             }
//             System.debug(codingSessProb.Problem__r.Description__c);
// 		}
// }
//         System.debug(myCodingSessionsDeveloperTeam);
//         System.debug('myCodingSessionsWithCildCodingSessionProblems ' + myCodingSessionsWithCildCodingSessionProblems);
//         System.debug('myCodingSessionsProblems ' + myCodingSessionsProblems);



//         for (Coding_Session_Problem__c codingSessProb : myCodingSessionsProblems){
//             System.debug(codingSessProb.Problem__r.Description__c);
//         }

    // }
}