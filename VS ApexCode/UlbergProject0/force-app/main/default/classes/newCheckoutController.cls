public class newCheckoutController {
  private Checkout__c newChout;

  //creates a new checkout table and assign it
  public Checkout__c getNewCheckout() {
    if (newChout == null) {
      newChout = new Checkout__c();
    }
    return newChout;
  }

  public PageReference save() {
    // Add the newChout to the database.
    insert newChout;
    // Send the user to the detail page for the newChout.
    PageReference newChoutPage = new PageReference(
      '/apex/CheckoutPage?id=' +
      newChout.id +
      '&key=true'
    );
    newChoutPage.setRedirect(true);
    return newChoutPage;
  }
}
