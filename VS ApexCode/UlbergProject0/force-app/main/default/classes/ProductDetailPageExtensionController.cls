public class ProductDetailPageExtensionController {
  final String checkoutPageName = 'https://codebreakers-developer-edition.na162.force.com/s/test-checkout';

  public String choutID { get; set; }
  public String countShoppingCart { get; set; }
  public String customerName { get; set; }
  public String confirmationMessage { get; set; }

  public ProductDetailPageExtensionController(ApexPages.StandardController sc) {
    this.customerName =
      'Customer Name: ' +
      Userinfo.getFirstName() +
      ' ' +
      Userinfo.getLastName();
    Checkout__c chout = (Checkout__c) [
      SELECT id, Full_Name__c, Items_In_Cart__c, OwnerId
      FROM Checkout__c
      WHERE OwnerId = :Userinfo.getuserId()
      LIMIT 1
    ];
    if (chout != null) {
      this.countShoppingCart =
        'Items in Checkout: ' + String.valueOf(chout.Items_In_Cart__c);
    } else {
      chout = new Checkout__c();
      chout.Full_Name__c =
        Userinfo.getFirstName() +
        ' ' +
        Userinfo.getLastName();
      insert chout;
      chout = (Checkout__c) [
        SELECT id, Full_Name__c, Items_In_Cart__c, OwnerId
        FROM Checkout__c
        WHERE OwnerId = :Userinfo.getuserId()
        LIMIT 1
      ];

      this.countShoppingCart = 'Items in Checkout: 0';
    }
  }
  /*
    public PageReference getCommunityURL() {
        String ntwrkId = Network.getNetworkId();
        ConnectApi.Community comm = ConnectApi.Communities.getCommunity(ntwrkId);
        return new Pagereference(comm.siteUrl);
    }
    
    public PageReference forwardToCommunityPage(String communityPage) {
        String ntwrkId = Network.getNetworkId();
        ConnectApi.Community comm = ConnectApi.Communities.getCommunity(ntwrkId);
        return new Pagereference(comm.siteUrl + '/s/' + communityPage);
    }
    */
  public void displayInfo(String message) {
    ApexPages.addmessage(
      new ApexPages.message(ApexPages.severity.INFO, confirmationMessage)
    );
  }
  public void addToCart() {
    Checkout__c chout = (Checkout__c) [
      SELECT id, Full_Name__c, Items_In_Cart__c, OwnerId
      FROM Checkout__c
      WHERE OwnerId = :Userinfo.getuserId()
      LIMIT 1
    ];
    if (chout == null) {
      chout = new Checkout__c();
      chout.Full_Name__c =
        Userinfo.getFirstName() +
        ' ' +
        Userinfo.getLastName();
      insert chout;
      chout = (Checkout__c) [
        SELECT id, Full_Name__c, Items_In_Cart__c, OwnerId
        FROM Checkout__c
        WHERE OwnerId = :Userinfo.getuserId()
        LIMIT 1
      ];
    }
    Shopping_Cart__c sc = new Shopping_Cart__c();
    String productId = apexPages.currentPage().getParameters().get('id');
    sc.Product__c = productId;
    sc.Checkout__c = chout.Id;
    this.choutID = chout.Id;
    insert sc;

    chout = (Checkout__c) [
      SELECT id, Full_Name__c, Items_In_Cart__c, OwnerId
      FROM Checkout__c
      WHERE OwnerId = :Userinfo.getuserId()
      LIMIT 1
    ];

    this.countShoppingCart =
      'Items in Checkout: ' + String.valueOf(chout.Items_In_Cart__c);
    this.confirmationMessage = 'item added to cart';
    displayInfo(this.confirmationMessage);
  }

  public String getCheckoutLink() {
    /*
          * it is in an iframe in a modal window so I'm just going to hard code this for now
        String ntwrkId = Network.getNetworkId();
        ConnectApi.Community comm = ConnectApi.Communities.getCommunity(ntwrkId);
        PageReference pr = new PageReference(comm.siteUrl + '/s/' + checkoutPageName);
        */
    PageReference pr = new PageReference(checkoutPageName);

    this.choutId = 'a005e0000067MapAAE';
    pr.getParameters().put('choutID', choutId);
    System.debug(pr.getURL());
    //pr.setRedirect(true);
    return pr.getUrl();
  }
}
