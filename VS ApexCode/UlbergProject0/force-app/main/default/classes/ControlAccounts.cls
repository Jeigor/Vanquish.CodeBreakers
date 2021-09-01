public class ControlAccounts {
  public Account acc { get; set; }

  public ControlAccounts(ApexPages.StandardController sc) {
    acc = new Account();
  }
  public id U = Userinfo.getUserId();
  public String AccsName { get; set; }
  public String BillState { get; set; }
  public String BillCity { get; set; }
  public String BillStreet { get; set; }
  public String BillPc { get; set; }
  public String ShipState { get; set; }
  public String ShipCity { get; set; }
  public String ShipStreet { get; set; }
  public String ShipPc { get; set; }
  public String errorMessage { get; set; }
  public list<Account> AccList;

  public void GetAcc() {
    AccList = [SELECT Name, id FROM Account];
    try {
      SObjectAccessDecision dec = Security.stripInaccessible(
        AccessType.READABLE,
        AccList
      );
      list<Account> SecurityAcc = dec.getRecords();
      for (Account accs : SecurityAcc) {
        if (accs.Name == AccsName) {
          acc = accs;
        } else {
          // acc = new Account();
        }
      }
      // acc = [Select id From Account where Name = '{!AccsName}' Limit 1];
      if (acc.Owner.id == U) {
        // acc = [SELECT Name FROM Account WHERE Name ='{!AccsName}' ];
        acc.BillingState = BillState;
        acc.BillingCity = BillCity;
        acc.BillingStreet = BillStreet;
        acc.BillingPostalCode = BillPc;
        acc.ShippingState = ShipState;
        acc.ShippingCity = ShipCity;
        acc.ShippingStreet = ShipStreet;
        acc.ShippingPostalCode = ShipPc;
        this.errorMessage = 'Updated your billing info';
      } else {
        // Here we want to add account if it doesnt match a name in the database
        acc.Name = AccsName;
        acc.BillingState = BillState;
        acc.BillingCity = BillCity;
        acc.BillingStreet = BillStreet;
        acc.BillingPostalCode = BillPc;
        acc.ShippingState = ShipState;
        acc.ShippingCity = ShipCity;
        acc.ShippingStreet = ShipStreet;
        acc.ShippingPostalCode = ShipPc;

        system.debug(acc);
        insert acc;
        this.errorMessage = 'Created an account for you';
      }
    } catch (Exception e) {
      system.debug(e.getMessage());
      this.errorMessage = 'Something Went wrong';
    }
  }
}
