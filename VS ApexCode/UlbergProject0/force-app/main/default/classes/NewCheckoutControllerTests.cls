@isTest
public class NewCheckoutControllerTests {
  //Sets current page for test
  @isTest
  public static void testNewCheckoutController() {
    PageReference pageRef = Page.NewCheckoutPage;
    Test.setCurrentPage(pageRef);

    //Instantiate NewCheckoutController
    newCheckoutController controller = new newCheckoutController();
    Checkout__c newRecord = controller.getNewCheckout();
    String nextPage = controller.save().getUrl();

    // Verify that the desired page displays
    System.assertEquals(
      '/apex/CheckoutPage?id=' +
      newRecord.id +
      '&key=true',
      nextPage
    );
  }
}
