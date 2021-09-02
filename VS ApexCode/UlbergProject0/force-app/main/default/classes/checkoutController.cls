public with sharing class checkoutController {
  private Checkout__c Chout;
  private List<Shopping_Cart__c> shoppingCart = new List<Shopping_Cart__c>();
  private Boolean needNewItem = false;
  private Shopping_Cart__c newItem;

  public checkoutController() {
    Chout = [
      SELECT
        id,
        Full_Name__c,
        Address__c,
        City__c,
        State__c,
        Zip_Code__c,
        Is_US_Address__c,
        Card_Number__c,
        Name_On_Card__c,
        Expiration_Date__c,
        Security_Code__c,
        Items_In_Cart__c
      FROM Checkout__c
      WHERE id = :apexPages.currentPage().getParameters().get('id')
    ];

    shoppingCart = [
      SELECT
        id,
        Checkout__r.id,
        Checkout__r.name,
        Product__r.name,
        Product__r.Asking_Price__c
      FROM Shopping_Cart__c
      WHERE Checkout__r.id = :Chout.id
    ];
  }
  //variable accessors
  public Checkout__c getCheckout() {
    return Chout;
  }
  public List<Shopping_Cart__c> getShoppingCart() {
    return shoppingCart;
  }
  public Shopping_Cart__c getNewItem() {
    return newItem;
  }
  public Boolean getNeedNewItem() {
    return needNewItem;
  }

  //save data and refresh page with new settings
  public PageReference save() {
    PageReference newChoutPage = Page.CheckoutPage;
    if (newChoutPage == null) {
      newChoutPage = Page.CheckoutPage;
      newChoutPage.getParameters().put('error', 'noParam');
    } else {
      try {
        update Chout;
        needNewItem = false;
        newChoutPage = new PageReference(
          '/apex/CheckoutPage?id=' +
          Chout.id +
          '&key=false'
        );
      } catch (Exception e) {
        newChoutPage = Page.CheckoutPage;
        newChoutPage.getParameters().put('error', 'noInsert');
      }
    }
    newChoutPage.setRedirect(true);
    return newChoutPage;
  }
  //clears input fields
  public PageReference cancel() {
    return null;
  }
  //saves new item to database and updates tables
  public PageReference addToCart() {
    insert newItem;
    update Chout;
    update shoppingCart;
    needNewItem = false;
    return null;
  }
  //instantiate new shopping cart and associate it with parent Chout
  //update table
  public PageReference newCart() {
    if (newItem == null)
      newItem = new Shopping_Cart__c();
    newItem.Checkout__c = Chout.id;
    needNewItem = true;
    update Chout;
    return null;
  }
  //refresh page with current values and allow access for record changes
  public PageReference updateInfo() {
    PageReference newChoutPage = new PageReference(
      '/apex/CheckoutPage?id=' +
      Chout.id +
      '&key=true'
    );
    newChoutPage.setRedirect(true);
    return newChoutPage;
  }
}
