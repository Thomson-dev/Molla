import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // Observable variables
  final carouselCurrentIndex = 0.obs;

  // Method to update the carousel current index
  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  // Initialize carousel controller if needed
  final bannerImages =
      [
        'assets/images/banner1.jpg',
        'assets/images/banner2.jpg',
        'assets/images/banner3.jpg',
      ].obs;

  // Method to navigate to product details
  void navigateToProductDetails(int productId) {
    // Implementation for navigation to product details
  }

  // Method to navigate to product listing by category
  void navigateToCategory(String categoryId) {
    // Implementation for navigation to category
  }

  // Fetch featured products from API or database
  void fetchFeaturedProducts() {
    // API call or database fetch implementation
  }

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }
}
