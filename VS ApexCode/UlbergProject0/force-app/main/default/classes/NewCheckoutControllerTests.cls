@isTest
public class NewCheckoutControllerTests {
  @isTest
  public static void testNewCheckoutController() {
    PageReference pageRef = Page.NewCheckoutPage;
    Test.setCurrentPage(pageRef);

    newCheckoutController controller = new newCheckoutController();
    Checkout__c newRecord = controller.getNewCheckout();
    String nextPage = controller.save().getUrl();

    // Verify that the success page displays
    System.assertEquals(
      '/apex/CheckoutPage?id=' +
      newRecord.id +
      '&key=true',
      nextPage
    );
  }
}
