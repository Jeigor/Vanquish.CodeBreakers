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
trigger slack_Developer_Team on Developer_Team__c (after insert, after update, before delete) {
	if(trigger.isAfter && trigger.isInsert || trigger.isAfter && trigger.isUpdate || trigger.isBefore && trigger.isDelete) {
		slackv2__.utilities.startSubscriptionQueue(trigger.newMap, trigger.oldMap, trigger.operationType, 'Developer_Team__c');
	}
}