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
public class CustomExtensionPageController {
  public CustomExtensionPageController(ApexPages.StandardController sc) {
  }
  // public List<Product2> getPdcts(){
  //     List<Product2> pdcts = [SELECT Id, Name, Description, Asking_Price__c FROM Product2 LIMIT 20];
  //     return pdcts;
  // }
  public Integer count { get; set; }

  // public void nameIt(){
  //     if(count == null){count =0;}
  //     this.pageName = 'Hello world ' + count;
  //     count++;
  // }
}
