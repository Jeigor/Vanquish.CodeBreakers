//copy of Rayshawn Initializer Extension for the checkout page.  Just in case needed to make last minute changes as Rayshawn was testing his code.
public with sharing class DanEditInitializerExtension {
  private final Checkout__c checkO;
  Integer total;

  public DanEditInitializerExtension(DanEditCheckoutController controller) {
    this.checkO = (Checkout__c) controller.getCheckout();
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
