/**
 * @description       : 
 * @author            : Daniel Boice
 * @group             : 
 * @last modified on  : 08-15-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-15-2021   Daniel Boice   Initial Version
**/
@isTest
public class slack_tst_Developer_Team {
	@isTest 
	static void testTrigger() {
		Developer_Team__c obj0 = new Developer_Team__c();
        obj0.Name = 'slack test name';
		insert obj0;
	}
}