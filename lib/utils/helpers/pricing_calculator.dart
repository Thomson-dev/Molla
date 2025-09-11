class TPricingCalculator {
  /// -- Calculate Price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  /// -- Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// Get tax rate for specific location
  static double getTaxRateForLocation(String location) {
    // Define tax rates for different locations
    switch (location.toLowerCase()) {
      case 'us':
      case 'united states':
        return 0.08; // 8% tax
      case 'ca':
      case 'canada':
        return 0.13; // 13% tax
      case 'uk':
      case 'united kingdom':
        return 0.20; // 20% VAT
      case 'de':
      case 'germany':
        return 0.19; // 19% VAT
      case 'fr':
      case 'france':
        return 0.20; // 20% VAT
      case 'au':
      case 'australia':
        return 0.10; // 10% GST
      case 'in':
      case 'india':
        return 0.18; // 18% GST
      case 'sg':
      case 'singapore':
        return 0.07; // 7% GST
      case 'jp':
      case 'japan':
        return 0.10; // 10% consumption tax
      case 'kr':
      case 'south korea':
        return 0.10; // 10% VAT
      default:
        return 0.00; // No tax for unknown locations
    }
  }

  /// Get shipping cost for specific location
  static double getShippingCost(String location) {
    // Define shipping costs for different locations
    switch (location.toLowerCase()) {
      case 'us':
      case 'united states':
        return 5.99; // $5.99 shipping
      case 'ca':
      case 'canada':
        return 12.99; // $12.99 shipping
      case 'uk':
      case 'united kingdom':
        return 8.99; // £8.99 shipping
      case 'de':
      case 'germany':
        return 9.99; // €9.99 shipping
      case 'fr':
      case 'france':
        return 9.99; // €9.99 shipping
      case 'au':
      case 'australia':
        return 15.99; // $15.99 shipping
      case 'in':
      case 'india':
        return 4.99; // ₹4.99 shipping
      case 'sg':
      case 'singapore':
        return 6.99; // $6.99 shipping
      case 'jp':
      case 'japan':
        return 11.99; // ¥11.99 shipping
      case 'kr':
      case 'south korea':
        return 10.99; // ₩10.99 shipping
      default:
        return 9.99; // Default shipping cost
    }
  }

  /// Calculate discount amount
  static double calculateDiscount(
    double originalPrice,
    double discountPercentage,
  ) {
    if (discountPercentage < 0 || discountPercentage > 100) {
      return 0.0; // Invalid discount percentage
    }
    return originalPrice * (discountPercentage / 100);
  }

  /// Calculate final price after discount
  static double calculateDiscountedPrice(
    double originalPrice,
    double discountPercentage,
  ) {
    double discountAmount = calculateDiscount(
      originalPrice,
      discountPercentage,
    );
    return originalPrice - discountAmount;
  }

  /// Calculate bulk discount
  static double calculateBulkDiscount(
    double unitPrice,
    int quantity,
    double bulkDiscountPercentage,
  ) {
    if (quantity < 2) return 0.0; // No bulk discount for single items

    double totalPrice = unitPrice * quantity;
    double bulkDiscount = totalPrice * (bulkDiscountPercentage / 100);
    return bulkDiscount;
  }

  /// Calculate final price with bulk discount
  static double calculateBulkPrice(
    double unitPrice,
    int quantity,
    double bulkDiscountPercentage,
  ) {
    double totalPrice = unitPrice * quantity;
    double bulkDiscount = calculateBulkDiscount(
      unitPrice,
      quantity,
      bulkDiscountPercentage,
    );
    return totalPrice - bulkDiscount;
  }

  /// Calculate tax amount only
  static double calculateTaxAmount(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    return productPrice * taxRate;
  }

  /// Calculate total with multiple products
  static double calculateTotalWithMultipleProducts(
    List<double> productPrices,
    String location,
  ) {
    double subtotal = productPrices.fold(0.0, (sum, price) => sum + price);
    double taxAmount = calculateTaxAmount(subtotal, location);
    double shippingCost = getShippingCost(location);

    return subtotal + taxAmount + shippingCost;
  }

  /// Calculate shipping cost based on weight
  static double calculateShippingByWeight(double weightInKg, String location) {
    double baseShippingCost = getShippingCost(location);

    if (weightInKg <= 1.0) {
      return baseShippingCost;
    } else if (weightInKg <= 5.0) {
      return baseShippingCost + 2.99;
    } else if (weightInKg <= 10.0) {
      return baseShippingCost + 5.99;
    } else {
      return baseShippingCost + 9.99;
    }
  }

  /// Calculate express shipping cost
  static double calculateExpressShipping(String location) {
    double standardShipping = getShippingCost(location);
    return standardShipping * 2.5; // Express shipping is 2.5x standard
  }

  /// Calculate overnight shipping cost
  static double calculateOvernightShipping(String location) {
    double standardShipping = getShippingCost(location);
    return standardShipping * 4.0; // Overnight shipping is 4x standard
  }

  /// Check if order qualifies for free shipping
  static bool qualifiesForFreeShipping(double orderTotal, String location) {
    // Free shipping threshold varies by location
    switch (location.toLowerCase()) {
      case 'us':
      case 'united states':
        return orderTotal >= 50.0; // Free shipping over $50
      case 'ca':
      case 'canada':
        return orderTotal >= 75.0; // Free shipping over $75
      case 'uk':
      case 'united kingdom':
        return orderTotal >= 60.0; // Free shipping over £60
      case 'au':
      case 'australia':
        return orderTotal >= 80.0; // Free shipping over $80
      default:
        return orderTotal >= 100.0; // Default threshold
    }
  }

  /// Calculate final shipping cost (considering free shipping)
  static double calculateFinalShippingCost(double orderTotal, String location) {
    if (qualifiesForFreeShipping(orderTotal, location)) {
      return 0.0; // Free shipping
    }
    return getShippingCost(location);
  }
}
