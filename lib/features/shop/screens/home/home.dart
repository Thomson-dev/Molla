import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/common/widgets/shimmer/shimmer_effect.dart';
import 'package:molla/features/authentication/controllers/user/user_controller.dart'
    show UserController;

import 'package:molla/features/shop/screens/home/widgets/popular_categories.dart';
import 'package:molla/features/shop/screens/home/widgets/product_card_vertical.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/constants/text_strings.dart';
import 'package:molla/utils/theme/color.dart';
import 'package:molla/widget/cuved-edged/cured_edged.dart';
import 'package:molla/widget/app_bar/appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device metrics for responsive sizing
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 380;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with curved edges
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                color: TColors.primary,
                // Responsive height based on screen size
                height: size.height * 0.45, // 45% of screen height
                child: Stack(
                  children: [
                    // Decorative Circles - responsive
                    _BackgroundCircles(screenWidth: size.width),
                    // Custom AppBar
                    const Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: HomeAppBar(),
                    ),
                    // SearchBar
                    Positioned(
                      top: size.height * 0.15, // Responsive positioning
                      left: 0,
                      right: 0,
                      child: HomeSearchBar(
                        padding: EdgeInsets.symmetric(
                          horizontal: TSizes.defaultSpace,
                        ),
                      ),
                    ),
                    // Popular Categories
                    const PopularCategories(),
                  ],
                ),
              ),
            ),

            // Carousel with responsive height
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: size.height * 0.25, // Responsive height
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
              items: const [
                TRoundedImage(imageUrl: TImages.productImage1),
                TRoundedImage(imageUrl: TImages.productImage2),
                TRoundedImage(imageUrl: TImages.productImage3),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Carousel indicators - responsive size
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: EdgeInsets.only(right: isSmallScreen ? 5 : 8),
                    child: Container(
                      // Responsive indicator size
                      width:
                          i == 0
                              ? (isSmallScreen ? 15 : 20)
                              : (isSmallScreen ? 8 : 10),
                      height: isSmallScreen ? 3 : 4,
                      margin: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 1 : 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            i == 0
                                ? TColors.primary
                                : TColors.primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),

            // Adaptive spacing
            SizedBox(
              height:
                  isSmallScreen
                      ? TSizes.spaceBtwItems
                      : TSizes.spaceBtwSections,
            ),

            // Popular Products heading - responsive text
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Popular Products',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        // Responsive text size
                        fontSize: isSmallScreen ? 18 : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Products Grid - responsive layout
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine columns based on available width
                  final double availableWidth = constraints.maxWidth;
                  final int columnCount = availableWidth > 600 ? 3 : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnCount,
                      mainAxisSpacing:
                          isSmallScreen ? TSizes.sm : TSizes.spaceBtwItems,
                      crossAxisSpacing:
                          isSmallScreen ? TSizes.sm : TSizes.spaceBtwItems,
                      // Responsive card height
                      mainAxisExtent: isSmallScreen ? 250 : 270,
                    ),
                    itemBuilder:
                        (_, index) => TProductCardVertical(
                          title: "Nike Air Zoom Pegasus",
                          image: TImages.productImage4,
                          price: 35.00,
                          oldPrice: 45.00,
                          discountTag: "25%",
                          onTap: () {
                            // Navigate to product details
                          },
                          onFavoriteTap: () {
                            // Toggle favorite
                          },
                          isFavorite: true,
                        ),
                  );
                },
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool applyImageRadius;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.applyImageRadius = true,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Use screen width for responsive sizing if not provided
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? size.width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(TSizes.md),
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(TSizes.md),
          child:
              isNetworkImage
                  ? Image.network(
                    imageUrl,
                    fit: fit,
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.error_outline,
                          size: 50,
                          color: TColors.primary,
                        ),
                  )
                  : Image.asset(imageUrl, fit: fit),
        ),
      ),
    );
  }
}

/// Responsive background circles
class _BackgroundCircles extends StatelessWidget {
  final double screenWidth;

  const _BackgroundCircles({this.screenWidth = 400});

  @override
  Widget build(BuildContext context) {
    final largeCircleSize = screenWidth * 0.8;
    final smallCircleSize = screenWidth * 0.6;

    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -250,
          child: TCircularContainer(
            backgroundColor: TColors.textWhite.withOpacity(0.3),
            width: largeCircleSize,
            height: largeCircleSize,
          ),
        ),
        Positioned(
          top: 200,
          right: -100,
          child: TCircularContainer(
            backgroundColor: TColors.textWhite.withOpacity(0.3),
            width: smallCircleSize,
            height: smallCircleSize,
          ),
        ),
      ],
    );
  }
}

/// Extracted AppBar for clarity and reusability
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 380;
    final controller = Get.put(UserController());

    return TAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context).textTheme.labelMedium!.apply(
              color: TColors.light,
              // Adaptive text size
              fontSizeFactor: isSmallScreen ? 0.9 : 1.0,
            ),
          ),
          Obx(() {
            // Show shimmer effect when profile is loading
            if (controller.profileLoading.value) {
              print("Profile loading: ${controller.profileLoading.value}");
              // Display a shimmer loader while user profile is being loaded
              return TShimmerEffect(width: 80, height: 15);
            } else {
              // Show the user's name when loaded
              return Text(
                'Hello ${controller.user.value.firstName}',
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: TColors.light,
                  // Adaptive text size
                  fontSizeFactor: isSmallScreen ? 0.9 : 1.0,
                ),
              );
            }
          }),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Iconsax.shopping_bag,
                color: TColors.light,
                // Adaptive icon size
                size: isSmallScreen ? 22 : 24,
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                // Adaptive badge size
                width: isSmallScreen ? 16 : 18,
                height: isSmallScreen ? 16 : 18,
                decoration: BoxDecoration(
                  color: TColors.dark,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: TColors.light,
                      fontSizeFactor: isSmallScreen ? 0.7 : 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HomeSearchBar extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const HomeSearchBar({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isSmallScreen = MediaQuery.of(context).size.width < 380;

    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: () {
          // Navigate to search screen or show search dialog
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          // Adaptive padding
          padding: EdgeInsets.all(isSmallScreen ? TSizes.md : TSizes.md),
          decoration: BoxDecoration(
            color: dark ? TColors.dark : TColors.light,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: Border.all(color: TColors.grey),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.search_normal,
                color: TColors.darkerGrey,
                // Adaptive icon size
                size: isSmallScreen ? 20 : 24,
              ),
              SizedBox(width: isSmallScreen ? TSizes.xs : TSizes.spaceBtwItems),
              Text(
                "Search in Store",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // Adaptive text size
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TCircularContainer extends StatelessWidget {
  final Color backgroundColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const TCircularContainer({
    super.key,
    required this.backgroundColor,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // Use provided dimensions or calculate based on screen size
      width: width ?? screenWidth * 0.7,
      height: height ?? screenWidth * 0.7,
      margin: margin,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
    );
  }
}
