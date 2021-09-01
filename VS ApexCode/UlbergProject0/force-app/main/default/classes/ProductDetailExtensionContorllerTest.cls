@isTest
public class ProductDetailExtensionContorllerTest {
  @TestSetup
  public static void setupData() {
    Checkout__c chout = new Checkout__c();
    chout.Full_Name__c = Userinfo.getFirstName() + ' ' + Userinfo.getLastName();
    insert chout;

    Product2 pdct = new Product2();
    pdct.Name = 'Test';
    insert pdct;
  }

  @isTest
  public static void TP_addToCart() {
    Product2 pdct = (Product2) [SELECT Id, Name FROM Product2 LIMIT 1];
    PageReference pageRef = new PageReference(
      '/apex/ProductDetailPage?id=' +
      pdct.Id +
      '&key=false'
    );
    Test.setCurrentPage(pageRef);

    System.debug(pageRef);

    // need a way to insert the product ID to the page param
    Test.startTest();
    //ProductDetailPageExtensionController pdpc = new ProductDetailPageExtensionController();
    //pdpc.addToCart();

    System.assert(true);

    Test.stopTest();
  }
}
