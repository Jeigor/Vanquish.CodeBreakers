public with sharing class InitializerExtension {

    private final Checkout__c checkO;
    Integer total;
    
    public initializerExtension(checkoutController controller) {
        this.checkO = (Checkout__c)controller.getCheckout();
    }
    public String getGreeting() {
        return checkO.full_name__c + ' Shipping Information';
    }
    public String getCardInfo() {
        return checkO.full_name__c + ' Billing Information';
    }
    public void setUSAddress() {
        checkO.is_us_address__c = true;
        update checkO;
    }
}