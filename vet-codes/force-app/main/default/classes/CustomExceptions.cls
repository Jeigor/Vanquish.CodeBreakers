/**
 * @description       : Class for project custom exceptions
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-12-2021
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
    
}