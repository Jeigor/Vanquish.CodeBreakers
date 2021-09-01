public class newCheckoutController {
  Checkout__c newChout;

  public Checkout__c getNewCheckout() {
    if (newChout == null) {
      newChout = new Checkout__c();
    }
    return newChout;
  }

  public PageReference save() {
    // Add the account to the database.
    insert newChout;
    // Send the user to the detail page for the new account.
    PageReference newChoutPage = new PageReference(
      '/apex/CheckoutPage?id=' +
      newChout.id +
      '&key=true'
    );
    newChoutPage.setRedirect(true);
    return newChoutPage;
  }
}
