/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-11-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-11-2021   Daniel Boice   Initial Version
**/
@isTest
public class slack_tst_Developer_Team {
	@isTest //
	static void testTrigger() {
		Developer_Team__c[] obj0 = [SELECT Send_Slack_Message__c , Name FROM Developer_Team__c LIMIT 1];
        
        
        Developer_Team__c dt = (Developer_Team__c) obj0[0];
        dt.Name = 'Test Name';
		dt.Send_Slack_Message__c = 'test send slack message';
        Boolean success = true;
        
        try {
            update dt;
        }
        catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
            success = false;
        }
        finally {
            System.assertEquals(true, success, 'test result of inserting team was '+ success);
        }
        
	}

}