/**
 * @description       :
 * @author            : Daniel Boice
 * @group             :
 * @last modified on  : 08-27-2021
 * @last modified by  : Daniel Boice
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   08-27-2021   Daniel Boice   Initial Version
 **/
public class ProductListPageController {
  // public ProductListPageController(ApexPages.StandardController sc) {

  // }
  public List<Product2> getPdcts() {
    List<Product2> pdcts = [
      SELECT Id, Name, Description, Asking_Price__c
      FROM Product2
      LIMIT 20
    ];
    return pdcts;
  }
  public Integer count { get; set; }
}
