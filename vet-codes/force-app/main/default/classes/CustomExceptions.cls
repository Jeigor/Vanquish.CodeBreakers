/**
 * @description       : Class for project custom exceptions
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-16-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-12-2021   Daniel Boice   Initial Version
**/

/*
From the Apex class: you can use the code below to throw custom exceptions

if( String.isEmpty(case.Analysis__c) ) {
throw new CustomExceptions.RequiredException(‘Analysis is missing from the Case’);
}
else {
throw new CustomExceptions.RequiredException(‘Cases can be assigned by Tier 1 or Admin Users’);
}
*/
public with sharing class CustomExceptions {
    
   
        public class InputDataException extends Exception {}
        public class RequiredException extends Exception {}
        public class GovernorLimitException extends Exception {}
        public class CommunityException extends Exception{}
        public class RecordLockedException extends Exception{}
        public class AuthorizationException extends Exception {}
        public class ClosedWonOrLostOpportunitiesExistException extends Exception {}

        public class DeletingProblemLinkedToCodingSessionException extends Exception {}
        final public static String ERROR_MESSAGE_DELETING_PROBLEM_LINKED_TO_CODING_SESSION='You are attempting to delete a Problem that is currently linked to a coding session, which is not allowed.';


        public class ErrorLinkingChildCodingSessionWhenInsertingStandupMeetingsException extends Exception {}
        final public static String ERROR_MESSAGE_LINKING_CODING_SESSION_WHEN_INSERTING_STANDUP='Problem occured when updating unassinged coding sessions to new standup meeting when inserted.';


        final public static String ERROR_MESSAGE_UNABLE_TO_UPDATE_DEV_TEAM_SLACK_MESS='problem updating the developer team record for slack message.';
        
       
        
}