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
public with sharing class ProductDetailPageControllerExtension {
  public ProductDetailPageControllerExtension(
    ApexPages.StandardController controller
  ) {
  }

  public String formatAskingPrice(Decimal price) {
    String s = '$' + price;
    if (!s.contains('.')) {
      s = s + '.00';
    } else {
      Integer dPos = s.indexOf('.');
      if (s.length() - dPos < 3) {
        s = s + '0';
      }
    }
    return s;
  }
  public String getDetailURL() {
    return 'https://' +
      ApexPages.currentPage().getHeaders().get('Host') +
      '/apex/ProductDetail';
  }
}
