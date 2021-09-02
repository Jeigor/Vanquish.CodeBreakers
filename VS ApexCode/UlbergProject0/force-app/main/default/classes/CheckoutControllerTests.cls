//An existing table is required to run the CheckoutPage
@isTest(SeeAllData=true)
public class CheckoutControllerTests {
  //Set page for test
  @isTest
  public static void testCheckoutController() {
    PageReference pageRef = new PageReference(
      '/apex/CheckoutPage?id=a005e0000067NsdAAE&key=false'
    );
    Test.setCurrentPage(pageRef);
    //verify the correct page is displayed
    System.debug(pageRef);
    //Instatiate CheckoutController and assign url
    CheckoutController controller = new CheckoutController();
    String nextPage = controller.save().getUrl();

    //Verify current page
    System.debug(nextPage);

    nextPage = controller.save().getUrl();

    //Add parameters to page URL
    ApexPages.currentPage().getParameters().put('id', 'a005e0000067NsdAAE');
    System.debug(pageRef);
    System.debug(nextPage);

    //Instantiate a new controller with all parameters in the page
    controller = new CheckoutController();

    Checkout__c newRecord = controller.getCheckout();
    List<Shopping_Cart__c> newShoppingList = controller.getShoppingCart();

    for (Shopping_Cart__c test : newShoppingList) {
      System.assertEquals(newRecord.id, test.Checkout__r.id);
    }
    Boolean bin = controller.getNeedNewItem();
    System.assertEquals(false, bin);

    nextPage = controller.save().getUrl();
    System.assertEquals(false, controller.getNeedNewItem());

    // Verify that the success page displays
    System.assertEquals(
      '/apex/CheckoutPage?id=' +
      newRecord.id +
      '&key=false',
      nextPage
    );
    System.debug(nextPage);

    controller.updateInfo();
    nextPage = controller.updateInfo().getUrl();
    System.assertEquals(
      '/apex/CheckoutPage?id=' +
      newRecord.id +
      '&key=true',
      nextPage
    );
    System.debug(nextPage);

    controller.newCart();
    Shopping_Cart__c nItem = controller.getNewItem();
    System.debug(nItem);

    System.assertEquals(true, controller.getNeedNewItem());
    System.debug(controller.getNeedNewItem());

    System.assertEquals(newRecord.id, nItem.Checkout__c);
    System.debug(nItem.Checkout__c);

    controller.addToCart();
    System.assertEquals(false, controller.getNeedNewItem());
    System.debug(controller.getNeedNewItem());
  }
}
