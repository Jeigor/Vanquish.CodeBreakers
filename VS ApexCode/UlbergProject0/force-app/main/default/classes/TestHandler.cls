@isTest
public class TestHandler {
    
    public testMethod static void TestReview(){
    list<Previously_Sold_Item__c> TestingList = new list <Previously_Sold_Item__c>();
        
  TriggerHandler Handle = new TriggerHandler();
        Contact Cont = new Contact();
         //cont.Id = 'MyCont';
        cont.FirstName = 'bob';
            cont.LastName = 'smith';
        
           insert(Cont);
      
        for(Integer num = 0; num < 25; num++) {
     
            TestingList.add(New Previously_Sold_Item__c(Name = 'SoldItem' +num));
            
        }
     
      cont = [Select id, name from contact where name like 'bob%'];
        for(Previously_Sold_Item__c item: TestingList){
            item.Contact__c = Cont.Id;
             if( item.Contact__c == Cont.Id) {
            boolean result = true;
             System.assertEquals(true, result);
        }
     
            
        }
        
        
    insert(TestingList);
     

       
       
}
    public testMethod static void TestSetup2(){
        
        Contact Cont = new Contact();
         //cont.Id = 'MyCont';
        cont.FirstName = 'bob';
            cont.LastName = 'smith';
        insert(Cont);
        
        Previously_sold_item__c PrevSold = new Previously_sold_Item__c();
        PrevSold.Contact__c = cont.Id;
        prevsold.Name = 'SoldItem';
        insert(PrevSold);
        PrevSold = [Select id, name From Previously_Sold_Item__c where name like 'SoldItem' limit 1];
        
          
        Rating__c MyRat = New Rating__c();
        MyRat.Contact__c = cont.Id;
        MyRat.Previously_Sold_Item__c = PrevSold.Id;
   
        insert(MyRat);
        if(MyRat.Contact__c == cont.Id){
            boolean MyRatTrue = true;
            system.assert(True, MyRatTrue);
        }
        Myrat.Rating_of_item__c = 5;
        update(Myrat);
        
    }
    
    
    
    
    
    
    }