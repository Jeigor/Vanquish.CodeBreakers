public class TestHelper {

      
    public static list<Previously_Sold_Item__c> SetupTests(List<Previously_Sold_Item__c> MyList){      
 List<Previously_Sold_Item__c> TestList = new List<Previously_Sold_Item__c>();
        for(Integer num = 0; num < 25; num++) {
            TestList.add(new Previously_Sold_Item__c(name = 'TestSold'+ num));
           
        }
       // insert(TestList);
         Return(TestList);
    }
    
}