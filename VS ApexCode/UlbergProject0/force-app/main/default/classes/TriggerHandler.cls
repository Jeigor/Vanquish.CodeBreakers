public class TriggerHandler {
    
    public static void createReview(list<Previously_Sold_Item__c> RevList) 
    {
        List<Rating__c> needReview = new List<Rating__c>();
        for(Previously_Sold_Item__c sold : RevList){
            needReview.add(CreateNewRating(sold));
            
        }   
        
        Insert needReview;
    }
    //Create new Rating
    @testVisible
    private static Rating__c CreateNewRating(Previously_Sold_Item__c SoldItem){
        Rating__C NewRating = new Rating__c();
        
        NewRating.Name= 'New Rating'+ SoldItem.Name;
        NewRating.Previously_Sold_Item__c = SoldItem.id;
        NewRating.Contact__c = SoldItem.Contact__c;
        return NewRating;
    }
   //Change value on sold item from rating object  
    public static void ChangeReview(list<Rating__c> RatList){
        
  list<Previously_Sold_Item__c> Reviewing = [Select id from Previously_Sold_Item__c];    
        for(Rating__c Rat : RatList){
     
           id prevSoldID =   Rat.Previously_Sold_Item__c;
              
                     for(Previously_Sold_Item__c Item : Reviewing){
                         if(Item.Id == prevSoldID){
                             Item.RatingNumber__c = Rat.Rating_of_item__c;
                         }
                         
                     }
        }
        update(Reviewing);

    }
    
 // Validation rule for  rating  must be between 1- 10
 
    public static void Validation(list<Rating__c> ValList){
        
        list<Rating__c> MyList =  ValList;
        
        for(Rating__c ValRat : ValList){
            
             Decimal ValInt = ValRat.Rating_of_item__c;
            if(ValInt > 10){
                ValRat.addError('Cannot go over 10');
            }
            if(ValInt < 1){
                ValRat.addError('Cannot go under 1');
            }
            
        }
     
        
    }    
    
    
    
    
}