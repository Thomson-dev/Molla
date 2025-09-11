import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                color: TColors.primary,
                height: 400,
                child: const Stack(
                  children: [
                    // Decorative Circles
                    _BackgroundCircles(),
                    // Custom AppBar
                    Positioned(top: 10, left: 0, right: 0, child: HomeAppBar()),
                    // SearchBar
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: HomeSearchBar(
                        padding: EdgeInsets.symmetric(
                          horizontal: TSizes.defaultSpace,
                        ),
                      ),
                    ),
                    // Popular Categories
                    PopularCategories(),
                  ],
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(viewportFraction: 1),
              items: const [
                TRoundedImage(imageUrl: TImages.productImage1),
                TRoundedImage(imageUrl: TImages.productImage2),
                TRoundedImage(imageUrl: TImages.productImage3),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Container(
                      width: i == 0 ? 20 : 10, // Active indicator is wider
                      height: 4, // Flat height for pill shape
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color:
                            i == 0
                                ? TColors.primary
                                : TColors.primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                          2,
                        ), // Small radius for slightly rounded corners
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(onPressed: () {}, child: const Text('View All')),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Grid
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: TSizes.spaceBtwItems,
                  crossAxisSpacing: TSizes.spaceBtwItems,
                  mainAxisExtent: 250,
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
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
                  ? Image.network(imageUrl, fit: fit)
                  : Image.asset(imageUrl, fit: fit),
        ),
      ),
    );
  }
}

/// Extracted background circles for clarity
class _BackgroundCircles extends StatelessWidget {
  const _BackgroundCircles();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -250,
          child: TCircularContainer(
            backgroundColor: TColors.textWhite.withOpacity(0.3),
          ),
        ),
        Positioned(
          top: 200,
          right: -100,
          child: TCircularContainer(
            backgroundColor: TColors.textWhite.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

/// Extracted AppBar for clarity and reusability
class HomeAppBar extends StatelessWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: TColors.light),
          ),
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: TColors.light),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.shopping_bag, color: TColors.light),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: TColors.dark,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: TColors.light,
                      fontSizeFactor: 0.8,
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

/// Extracted SearchBar for clarity and reusability
class HomeSearchBar extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const HomeSearchBar({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: () {
          // Navigate to search screen or show search dialog
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: dark ? TColors.dark : TColors.light,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: Border.all(color: TColors.grey),
          ),
          child: Row(
            children: [
              Icon(Iconsax.search_normal, color: TColors.darkerGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                "Search in Store",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy TCircularContainer for illustration. Replace with your actual widget.
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
    return Container(
      width: width ?? 300,
      height: height ?? 300,
      margin: margin,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
    );
  }
}
