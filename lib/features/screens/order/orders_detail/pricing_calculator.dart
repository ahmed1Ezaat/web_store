class TPricingCalculator {
  // 1. تصحيح اسم الفئة

  // -- Calculate Total Price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;

    return totalPrice;
  }

  // -- Calculate shipping cost (إرجاع قيمة مالية كرقم)
  static String calculateShippingCost(double productPrice, String location) {
   double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  // -- Calculate tax (إرجاع قيمة مالية كرقم)
  static String calculateTax(double productPrice, String location) {
    // 3. تصحيح نوع الإرجاع
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // مثال: 10% ضريبة
    return 0.10;
  }

  static double getShippingCost(String location) {
    // مثال: تكلفة شحن ثابتة $5
    return 5.00;
  }

  // -- Calculate cart total
  //static double calculateCartTotal(List<CartItem> cartItems) {
    // 4. إضافة معلمات صحيحة
  //  return cartItems.fold(
    //  0.0,
//(previousValue, item) =>
        //  previousValue + (item.price ?? 0.0), // 5. معالجة القيم الفارغة
    //);
  }

