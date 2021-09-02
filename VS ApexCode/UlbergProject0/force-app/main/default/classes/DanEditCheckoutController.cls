//some last minute changes to Rayshawns code just to display the checkout items and not create a new checkout object on the page
public with sharing class DanEditCheckoutController {
    private final Checkout__c Chout;
    List<Shopping_Cart__c> shoppingCart = new List<Shopping_Cart__c>();
    Boolean needNewItem = false;
    Shopping_Cart__c newItem;
        
    public DanEditCheckoutController() {
        //only thing changed from Rayshawns code was to get the checkout based on UserInfo.Id and linked to OwnerId in the checkout, currently creates an error in the page if sample data for checkout object not entered first. need to add code for creating checkout if does not exist and check
        Chout = [SELECT id , Full_Name__c , Address__c, City__c, State__c, Zip_Code__c, Is_US_Address__c, Card_Number__c, Name_On_Card__c, Expiration_Date__c, Security_Code__c, Items_In_Cart__c, OwnerId FROM Checkout__c
                   WHERE OwnerId = :UserInfo.getUserId() Limit 1]; 

        shoppingCart = [SELECT id, Checkout__r.id, Checkout__r.name, Product__r.name, Product__r.Asking_Price__c FROM Shopping_Cart__c WHERE Checkout__r.id = :Chout.id];       
    }
    public Checkout__c getCheckout() {
        return Chout;
    }
    public List<Shopping_Cart__c> getShoppingCart() {
        return shoppingCart;
    }   
    public Shopping_Cart__c getNewItem() {
        return newItem;
    }
    public Boolean getNeedNewItem() {
        return needNewItem;
    }
    
    public PageReference save() {
        update Chout;
        needNewItem = false;
        PageReference newChoutPage = new PageReference('/apex/CheckoutPage?id=' + Chout.id + '&key=false');
        newChoutPage.setRedirect(true);
        return newChoutPage;        
    }
    public PageReference cancel() {
        return null;
    }
    public PageReference addToCart() {
        insert newItem;
        update Chout;
        update shoppingCart;
        needNewItem = false;
        return null;
    }
    public PageReference newCart() {
        if(newItem == null) newItem = new Shopping_Cart__c();
        newItem.Checkout__c = Chout.id;
        needNewItem = true;
        update Chout;
        return null;
    }
    public PageReference updateInfo() {
        PageReference newChoutPage = new PageReference('/apex/CheckoutPage?id=' + Chout.id + '&key=true');
        newChoutPage.setRedirect(true);
        return newChoutPage;
    }
}