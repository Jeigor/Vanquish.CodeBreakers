/**
 * @description       : This was originally used in the product list page, but then later not needed or used.  Used standard controller for the list page.
 * @author            : Daniel Boice
 * @group             :
 * @last modified on  : 08-27-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-27-2021   Daniel Boice   Initial Version
 **/
public with sharing class ProductListPageControllerExtension {
  // public List<Product2> getPdcts() {
  //     return [Select Id, Name, Description, Asking_Price__c
  //     From Product2];
  //    }
  //    public List<Schema.Account> productList = new List<Schema.Product2>();

  public ProductListPageControllerExtension(
    ApexPages.StandardController controller
  ) {
    // pdct = (Product2) controller.getRecord();
  }
  public List<Product2> getProducts() {
    return [
      SELECT Id, Name, Description, Asking_Price__c, DisplayUrl
      FROM Product2
    ];
  }
    //brave-shark-5267fr-dev-ed--c.visualforce.com/apex/ProductDetail?
  public String getDetailURL() {
    return 'https://' +
      'brave-shark-5267fr-dev-ed--c.visualforce.com' +
      '/apex/ProductDetail';
  }
    
  //   public Product2 pdct {get; set;}
  //   List<Product2> pdcts {get;set;}

  //    public PageReference siteValue(){
  //      if(pdct.Site == null || pdct.Site.trim() == ''){
  //        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No value found'));
  //      }
  //      return null;
  //    }
}