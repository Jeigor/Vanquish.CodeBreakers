@isTest
public class  ProductDetailExtensionContorllerTest{
    
    @TestSetup
    public static void setupData(){
    	List<Contact> ctList =new List<Contact>();
        for(Integer i=0;i<3;i++){
        Contact ct = new Contact ();
      
        ct.FirstName = 'test ' +i;
        ct.LastName = 'test '+i;
            ctList.add(ct);
        }
        insert ctList;
        
        List<Contact > ctsAfterInsert = [SELECT Id, FirstName FROM Contact WHERE FirstName ='test 1'];
        System.AssertNotEquals(ctsAfterInsert.size(), 0,' Should have created a contact');
        Contact ctAfterInsert = (Contact)ctsAfterInsert[0];
        List<Product2> pdctList =new List<Product2>();
        for(Integer i=0;i<3;i++){
        Product2 pdct = new Product2();
       pdct.Name = 'Test '+i;
        pdct.Date_Posted__c = System.today();
       pdct.Contact__c=ctAfterInsert.Id;
        pdct.Asking_Price__c= 30.0;
            pdctList.add(pdct);
        }
        insert pdctList;
        
        List<Product2> pdctsAfterInsert = [SELECT Id FROM Product2];
        /// should be one 
        System.assertNotEquals(pdctsAfterInsert.size(),0, 'should have created at least 1 product');
    }
    
    @isTest
    public static void TP_addToCart(){
    
        Test.startTest();
        List<Product2> pdcts =  [SELECT Id, Name FROM Product2 WHERE Name = 'Test 1'];
        System.assertEquals(pdcts.size(),1, 'should returned two products');
        Product2 pdct = (Product2)pdcts[0];
     PageReference pageRef = new PageReference('/apex/ProductDetailPage?id='+pdct.Id+'&key=false');
     Test.setCurrentPage(pageRef);
        
      //  System.debug(pageRef);
      
        
        
    
    
    ApexPages.StandardController pdctStandardController = new ApexPages.StandardController(pdct);
        ProductDetailPageExtensionController pdpc = new ProductDetailPageExtensionController(pdctStandardController);
        List<Checkout__c> chout1List = [SELECT id , Full_Name__c , Items_In_Cart__c, OwnerId FROM Checkout__c
                   WHERE OwnerId = :Userinfo.getuserId() ];
        System.assertEquals(chout1List.size(),1, 'chout is null after controller initialized, should have created a checkout object if one did not exist' );
       Checkout__c chout1 =(Checkout__c) chout1List[0];
    //now lets try to add the product to the cart
        pdpc.addToCart();
        //should have created a a new checkout of none exists and add a shopping cart with the product and checkout
     //query the checkout to see if it was created 
     List<Checkout__c> chout2List = [SELECT id , Full_Name__c , Items_In_Cart__c, OwnerId FROM Checkout__c
                   WHERE OwnerId = :Userinfo.getuserId() ];
        System.assertEquals(chout2List.size(),1, 'chout2 is null after adding product to cart, should have created a checkout object if one did not exist' );
       Checkout__c chout2 =(Checkout__c) chout2List[0];
    System.assertEquals(chout2.Items_In_Cart__c, 1, 'should have one item in the cart');
    
    // now lets add another product and try it with an existing checkout object again
    
	//get the product Id
	//
	Product2 pdctAfterInsert = [SELECT Id, Name FROM Product2 WHERE Name ='Test 2'];  
        
	PageReference pageRef2 = new PageReference('/apex/ProductDetailPage?id='+pdctAfterInsert.Id+'&key=false');
    Test.setCurrentPage(pageRef2);
    //now add it to the product to the cart, there should already be a cart created in previous step
  	pdpc.addToCart();
    List<Checkout__c> chout3List = [SELECT id , Full_Name__c , Items_In_Cart__c, OwnerId FROM Checkout__c
                   WHERE OwnerId = :Userinfo.getuserId() ];
        System.assertEquals(chout3List.size(),1, 'chout not equal to on after previously adding product to cart, should have created a checkout object if one did not exist and found that' );
       Checkout__c chout3 =(Checkout__c) chout3List[0];
    
    System.assertEquals(chout3.Items_In_Cart__c, 2, 'should have two products in the cart');
        
        
        
    Test.stopTest();
    
    
    }
    
    @isTest 
    public static void TP_getCheckoutLink(){
        Test.startTest();
         Product2 pdct = new Product2();
        ApexPages.StandardController pdctStandardController = new ApexPages.StandardController(pdct);
        ProductDetailPageExtensionController pdpc = new ProductDetailPageExtensionController(pdctStandardController);
        System.assertEquals('https://codebreakers-developer-edition.na162.force.com/s/test-checkout?choutID=a005e0000067MapAAE', pdpc.getCheckoutLink(), 'http link is differnt than expected');
        Test.stopTest();
    }

}