@isTest
public class PageTester {
  @TestSetup
  public static void Setup() {
    /*    Account accs = new Account();
        accs.Name = 'Name';
        insert accs;
       ApexPages.StandardController c = new ApexPages.StandardController(Accs);
        ControlAccounts ConAcc = new ControlAccounts(c); */
  }

  @isTest
  static void TestGetAcc() {
    Account accs = new Account();

    accs.Name = 'Name';
    insert accs;
    ApexPages.StandardController c = new ApexPages.StandardController(Accs);
    ControlAccounts ConAcc = new ControlAccounts(c);
    Test.startTest();
    PageReference PageRef = Page.AccountDisplayEdit;
    Test.setCurrentPage(PageRef);

    // Account accs = [Select Name From Account Where Name = 'Name'];
    ConAcc.GetAcc();
    Test.stopTest();
  }
}
