/// LIST OF Enums
/// They cannot be created inside a class.

enum TextSizes { small, medium, large }

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
  returned,
  refunded,
}

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  debitCard,
  paystack,
  razorPay,
  paytm,
  cashOnDelivery,
  bankTransfer,
}

enum UserRole { customer, admin, vendor, moderator }

enum ProductCategory {
  electronics,
  clothing,
  books,
  home,
  sports,
  beauty,
  automotive,
  toys,
  health,
  food,
  jewelry,
  furniture,
}

enum ProductCondition { brandNew, used, refurbished, vintage }

enum ShippingMethod { standard, express, overnight, sameDay, pickup }

enum AddressType { home, work, other, billing, shipping }

enum NotificationType { orderUpdate, promotional, news, security, system }

enum ThemeMode { light, dark, system }

enum Language {
  english,
  spanish,
  french,
  german,
  chinese,
  japanese,
  arabic,
  hindi,
}

enum SortOrder { ascending, descending }

enum FilterType { price, brand, rating, availability, category, size, color }

enum CartAction { add, remove, update, clear }

enum SearchType { product, category, brand, tag }

enum ReviewRating { one, two, three, four, five }

enum CouponType { percentage, fixed, freeShipping, buyOneGetOne }

enum SubscriptionStatus { active, inactive, pending, cancelled, expired }

enum PaymentStatus { pending, completed, failed, refunded, cancelled }

enum DeliveryStatus {
  pending,
  confirmed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  failed,
  returned,
}

enum UserStatus { active, inactive, suspended, banned, pending }

enum FileType { image, video, document, audio, archive }

enum ImageQuality { low, medium, high, original }

enum ValidationType {
  email,
  phone,
  password,
  username,
  required,
  minLength,
  maxLength,
  pattern,
}

enum ApiResponseStatus {
  success,
  error,
  loading,
  noData,
  networkError,
  unauthorized,
  forbidden,
  notFound,
  serverError,
}

enum BottomNavItem { home, categories, cart, orders, profile }

enum DialogType { info, success, warning, error, confirmation, input }

enum AnimationType { fade, slide, scale, rotation, bounce, elastic }

enum GestureType { tap, doubleTap, longPress, drag, pinch, rotate }
