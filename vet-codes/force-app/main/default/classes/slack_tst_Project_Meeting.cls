@isTest
public class slack_tst_Project_Meeting {
	@isTest 
	static void testTrigger() {
		Meeting__c obj2 = new Meeting__c();
		insert obj2;

		Project__c obj1 = new Project__c();
		insert obj1;

		Project_Meeting__c obj0 = new Project_Meeting__c(
			Project__c = obj1.Id,
			Meeting__c = obj2.Id
		);
		insert obj0;
	}
}