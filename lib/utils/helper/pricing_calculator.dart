class DPricingCalculator{
  static double calculateTotalPrice(double productPrice,String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice*taxRate;
    double shippingCost = getShippingCost(location);
    return productPrice+taxAmount+shippingCost;
  }
  static String caculateTax(double productPrice,String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice*taxRate;
    return taxAmount.toStringAsFixed(2);
  }
  static String caculateShippingCost(double productPrice,String location){
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }
  static double getTaxRateForLocation(String location){
    return 0.1;
  }
  static double getShippingCost(String location){
    return 5.0;
  }
}