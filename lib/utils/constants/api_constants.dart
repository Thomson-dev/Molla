/// LIST OF Constants used in APIs
class APIConstants {
  // API Base URLs
  static const String baseURL = "https://api.t-store.com";
  static const String baseURLDev = "https://dev-api.t-store.com";
  static const String baseURLStaging = "https://staging-api.t-store.com";
  static const String baseURLLocal = "http://localhost:3000";

  // API Version
  static const String apiVersion = "v1";
  static const String apiVersionV2 = "v2";

  // API Endpoints
  static const String authEndpoint = "/auth";
  static const String usersEndpoint = "/users";
  static const String productsEndpoint = "/products";
  static const String categoriesEndpoint = "/categories";
  static const String ordersEndpoint = "/orders";
  static const String cartEndpoint = "/cart";
  static const String paymentsEndpoint = "/payments";
  static const String addressesEndpoint = "/addresses";
  static const String reviewsEndpoint = "/reviews";
  static const String wishlistEndpoint = "/wishlist";
  static const String notificationsEndpoint = "/notifications";
  static const String searchEndpoint = "/search";
  static const String uploadEndpoint = "/upload";
  static const String analyticsEndpoint = "/analytics";

  // Authentication Endpoints
  static const String loginEndpoint = "/login";
  static const String registerEndpoint = "/register";
  static const String logoutEndpoint = "/logout";
  static const String refreshTokenEndpoint = "/refresh";
  static const String forgotPasswordEndpoint = "/forgot-password";
  static const String resetPasswordEndpoint = "/reset-password";
  static const String verifyEmailEndpoint = "/verify-email";
  static const String resendVerificationEndpoint = "/resend-verification";

  // User Endpoints
  static const String profileEndpoint = "/profile";
  static const String updateProfileEndpoint = "/update-profile";
  static const String changePasswordEndpoint = "/change-password";
  static const String deleteAccountEndpoint = "/delete-account";
  static const String userOrdersEndpoint = "/orders";
  static const String userAddressesEndpoint = "/addresses";
  static const String userWishlistEndpoint = "/wishlist";

  // Product Endpoints
  static const String productDetailsEndpoint = "/details";
  static const String productSearchEndpoint = "/search";
  static const String productFilterEndpoint = "/filter";
  static const String productRecommendationsEndpoint = "/recommendations";
  static const String productReviewsEndpoint = "/reviews";
  static const String productImagesEndpoint = "/images";
  static const String productVariantsEndpoint = "/variants";

  // Order Endpoints
  static const String createOrderEndpoint = "/create";
  static const String orderHistoryEndpoint = "/history";
  static const String orderTrackingEndpoint = "/track";
  static const String cancelOrderEndpoint = "/cancel";
  static const String returnOrderEndpoint = "/return";
  static const String orderInvoiceEndpoint = "/invoice";

  // Cart Endpoints
  static const String addToCartEndpoint = "/add";
  static const String removeFromCartEndpoint = "/remove";
  static const String updateCartEndpoint = "/update";
  static const String clearCartEndpoint = "/clear";
  static const String cartItemsEndpoint = "/items";
  static const String cartSummaryEndpoint = "/summary";

  // Payment Endpoints
  static const String createPaymentEndpoint = "/create";
  static const String confirmPaymentEndpoint = "/confirm";
  static const String paymentStatusEndpoint = "/status";
  static const String refundPaymentEndpoint = "/refund";
  static const String paymentMethodsEndpoint = "/methods";
  static const String paymentHistoryEndpoint = "/history";

  // Upload Endpoints
  static const String uploadImageEndpoint = "/image";
  static const String uploadDocumentEndpoint = "/document";
  static const String uploadAvatarEndpoint = "/avatar";
  static const String uploadProductImageEndpoint = "/product-image";

  // Search Endpoints
  static const String searchProductsEndpoint = "/products";
  static const String searchCategoriesEndpoint = "/categories";
  static const String searchBrandsEndpoint = "/brands";
  static const String searchSuggestionsEndpoint = "/suggestions";
  static const String searchHistoryEndpoint = "/history";
  static const String searchTrendingEndpoint = "/trending";

  // API Headers
  static const String contentTypeHeader = "Content-Type";
  static const String authorizationHeader = "Authorization";
  static const String acceptHeader = "Accept";
  static const String userAgentHeader = "User-Agent";
  static const String apiKeyHeader = "X-API-Key";
  static const String clientVersionHeader = "X-Client-Version";
  static const String deviceIdHeader = "X-Device-ID";
  static const String platformHeader = "X-Platform";

  // Content Types
  static const String applicationJson = "application/json";
  static const String applicationFormData = "multipart/form-data";
  static const String applicationXWwwFormUrlencoded =
      "application/x-www-form-urlencoded";
  static const String textPlain = "text/plain";

  // HTTP Methods
  static const String getMethod = "GET";
  static const String postMethod = "POST";
  static const String putMethod = "PUT";
  static const String patchMethod = "PATCH";
  static const String deleteMethod = "DELETE";

  // API Response Keys
  static const String successKey = "success";
  static const String messageKey = "message";
  static const String dataKey = "data";
  static const String errorKey = "error";
  static const String errorsKey = "errors";
  static const String tokenKey = "token";
  static const String refreshTokenKey = "refreshToken";
  static const String userKey = "user";
  static const String paginationKey = "pagination";
  static const String totalKey = "total";
  static const String pageKey = "page";
  static const String limitKey = "limit";

  // API Error Codes
  static const String unauthorizedError = "UNAUTHORIZED";
  static const String forbiddenError = "FORBIDDEN";
  static const String notFoundError = "NOT_FOUND";
  static const String validationError = "VALIDATION_ERROR";
  static const String serverError = "SERVER_ERROR";
  static const String networkError = "NETWORK_ERROR";
  static const String timeoutError = "TIMEOUT_ERROR";
  static const String rateLimitError = "RATE_LIMIT_ERROR";

  // API Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // API Rate Limiting
  static const int maxRequestsPerMinute = 100;
  static const int maxRequestsPerHour = 1000;
  static const int maxRequestsPerDay = 10000;

  // API Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int minPageSize = 1;

  // API Cache
  static const int cacheExpiryTime = 300000; // 5 minutes
  static const int maxCacheSize = 100; // MB

  // API Keys (Replace with your actual keys)
  static const String tSecretAPIKey =
      "cwt_live_b2da6ds3df3e785v8ddc59198f7615ba";
  static const String publicAPIKey = "pk_live_public_key_here";
  static const String stripePublishableKey = "pk_live_stripe_key_here";
  static const String googleMapsAPIKey = "google_maps_api_key_here";
  static const String firebaseAPIKey = "firebase_api_key_here";

  // Third-party API URLs
  static const String stripeAPIURL = "https://api.stripe.com";
  static const String paypalAPIURL = "https://api.paypal.com";
  static const String googleMapsAPIURL = "https://maps.googleapis.com";
  static const String firebaseAPIURL = "https://firebase.googleapis.com";

  // WebSocket Endpoints
  static const String wsBaseURL = "wss://ws.t-store.com";
  static const String wsNotificationsEndpoint = "/notifications";
  static const String wsChatEndpoint = "/chat";
  static const String wsOrdersEndpoint = "/orders";

  // API Status Codes
  static const int statusOK = 200;
  static const int statusCreated = 201;
  static const int statusAccepted = 202;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusMethodNotAllowed = 405;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusTooManyRequests = 429;
  static const int statusInternalServerError = 500;
  static const int statusBadGateway = 502;
  static const int statusServiceUnavailable = 503;
}
