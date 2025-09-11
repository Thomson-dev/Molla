import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molla/features/shop/screens/home/home.dart';
import 'package:molla/features/shop/screens/home/widgets/product_card_vertical.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/theme/color.dart';
import 'package:molla/widget/app_bar/appbar.dart';
import 'package:molla/utils/helpers/helper_functions.dart';
import 'package:molla/widget/cuved-edged/cured_edged.dart' as cured;

/// Store screen with categories and products
class StoreScreen extends StatelessWidget {
  /// Constructor for the store screen
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder:
                    (_, innerBoxScrolled) => [
                      _buildSliverAppBar(context, isDark),

                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          _buildTabBar(context, isDark),
                        ),
                        pinned: true,
                      ),
                    ],
                body: const TabBarView(
                  children: [
                    _TabContentView(category: 'Sports'),
                    _TabContentView(category: 'Furniture'),
                    _TabContentView(category: 'Electronics'),
                    _TabContentView(category: 'Clothes'),
                    _TabContentView(category: 'Cosmetics'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// List of tab categories
  static const List<String> _tabs = [
    'Sports',
    'Furniture',
    'Electronics',
    'Clothes',
    'Cosmetics',
  ];

  /// Build the tabBar with proper styling
  TabBar _buildTabBar(BuildContext context, bool isDark) {
    return TabBar(
      isScrollable: true,
      indicatorColor: TColors.primary,
      unselectedLabelColor: TColors.darkerGrey,
      labelColor: isDark ? TColors.light : TColors.primary,
      tabs: _tabs.map((tab) => Tab(child: Text(tab))).toList(),
    );
  }

  /// Custom AppBar with shopping cart icon
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return TAppBar(
      title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
      actions: [_buildCartIcon(context)],
    );
  }

  /// Shopping cart icon with counter badge
  Widget _buildCartIcon(BuildContext context) {
    const int cartItemCount = 2;

    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.shopping_bag, color: TColors.grey),
        ),
        if (cartItemCount > 0) _buildCartBadge(context, cartItemCount),
      ],
    );
  }

  /// Badge showing number of items in cart
  Widget _buildCartBadge(BuildContext context, int count) {
    return Positioned(
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
            count.toString(),
            style: Theme.of(context).textTheme.labelLarge!.apply(
              color: TColors.light,
              fontSizeFactor: 0.8,
            ),
          ),
        ),
      ),
    );
  }

  /// SliverAppBar with header content
  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false, // Changed from true to false to prevent unexpected jumps
      snap: false, // Changed from true to false for smoother scrolling
      backgroundColor: isDark ? TColors.dark : TColors.light,
      expandedHeight: 400, // Slightly reduced height for better proportions
      elevation: 1.0, // Increased slightly for better shadow definition
      shadowColor: Colors.black.withOpacity(0.1), // Softer shadow
      collapsedHeight: kToolbarHeight, // Keep this for consistency
      forceElevated: true, // Always show the elevation
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, // Parallax effect when scrolling
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          decoration: BoxDecoration(
            color: isDark ? TColors.dark : TColors.light,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                _buildSearchBar(context, isDark),
                const SizedBox(height: TSizes.spaceBtwItems),

                // Featured Products Header
                _buildSectionHeader(
                  context,
                  title: 'Featured Products',
                  actionText: 'View All',
                  onActionPressed: () {},
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                // Store Categories Grid
                Expanded(child: _buildStoreInfoContainer(context, isDark)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Custom search bar that looks better
  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color:
            isDark ? TColors.darkerGrey.withOpacity(0.5) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        border: Border.all(
          color: isDark ? Colors.transparent : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search in store...',
          prefixIcon: const Icon(Iconsax.search_normal, size: 18),
          prefixIconColor: TColors.grey,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: TColors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
        ),
      ),
    );
  }

  /// Store info grid with store categories
  Widget _buildStoreInfoContainer(BuildContext context, bool isDark) {
    return const _StoreCategories();
  }

  /// Section header with title and action button
  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    String? actionText,
    VoidCallback? onActionPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          if (actionText != null)
            TextButton(onPressed: onActionPressed, child: Text(actionText)),
        ],
      ),
    );
  }
}

/// Widget to display store categories in a grid
class _StoreCategories extends StatelessWidget {
  const _StoreCategories();

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.md,
        crossAxisSpacing: TSizes.md,
        childAspectRatio: 2.2,
      ),
      itemCount: _storeCategories.length,
      itemBuilder:
          (context, index) => _StoreCategoryCard(
            category: _storeCategories[index],
            isDark: isDark,
          ),
    );
  }

  /// List of store categories with icons and names
  static const List<Map<String, String>> _storeCategories = [
    {'icon': TImages.clothIcon, 'name': 'Fashion', 'products': '256'},
    {'icon': TImages.clothIcon, 'name': 'Footwear', 'products': '125'},
    {'icon': TImages.clothIcon, 'name': 'Electronics', 'products': '89'},
    {'icon': TImages.clothIcon, 'name': 'Beauty', 'products': '143'},
  ];
}

/// Individual store category card
class _StoreCategoryCard extends StatelessWidget {
  final Map<String, String> category;
  final bool isDark;

  const _StoreCategoryCard({required this.category, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: cured.TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // Icon with circular background
            _buildCategoryIcon(context),
            const SizedBox(width: TSizes.sm),
            // Category info text
            _buildCategoryInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      padding: const EdgeInsets.all(TSizes.xs),
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : TColors.light,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        image: AssetImage(category['icon']!),
        color: isDark ? TColors.light : TColors.dark,
      ),
    );
  }

  Widget _buildCategoryInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category['name']!,
            style: Theme.of(context).textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: TSizes.xs),
          Text(
            '${category['products']} items',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

/// Tab content view for each category
class _TabContentView extends StatelessWidget {
  final String category;

  const _TabContentView({required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use CustomScrollView to fix overflow issues
        return SingleChildScrollView(
          key: ValueKey(category),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Brands
                  cured.TRoundedContainer(
                    showBorder: true,
                    borderColor: TColors.grey,
                    backgroundColor: Colors.transparent,
                    margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                    child: Column(
                      children: [
                        // Header or title for the brands section
                        Padding(
                          padding: const EdgeInsets.all(TSizes.md),
                          child: Text(
                            '$category Brands',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        // Brands content
                        _buildBrandsContent(context, isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Product grid section title
                  Text(
                    'Popular Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Products you might like section
                  ///
                  ///
                  // _buildSectionHeader(
                  //   context,
                  //    'You might like',
                  //    onPressed: () {},
                  //    ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Products grid - FIX FOR OVERFLOW
                  _buildProductsGrid(context, isDark),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build product grid with vertical product cards
  Widget _buildProductsGrid(BuildContext context, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.6, // Adjusted to prevent overflow
      ),
      itemCount: 4,
      itemBuilder:
          (context, index) => TProductCardVertical(
            title: "Nike Air Zoom Pegasus",
            image: TImages.productImage4,
            price: 35.00,
            oldPrice: 45.00,
            discountTag: "25%",
            onTap: () {},
            onFavoriteTap: () {},
            isFavorite: true,
          ),
    );
  }

  // Build brands content
  Widget _buildBrandsContent(BuildContext context, bool isDark) {
    // Example grid of brand logos
    return Padding(
      padding: const EdgeInsets.only(
        left: TSizes.md,
        right: TSizes.md,
        bottom: TSizes.md,
      ),
      child: Column(
        children: [
          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBrandLogo(context, isDark, 'Nike'),
              _buildBrandLogo(context, isDark, 'Adidas'),
              _buildBrandLogo(context, isDark, 'Puma'),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          // Row 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBrandLogo(context, isDark, 'Reebok'),
              _buildBrandLogo(context, isDark, 'UA'),
              _buildBrandLogo(context, isDark, 'NB'),
            ],
          ),
        ],
      ),
    );
  }

  // Build individual brand logo
  Widget _buildBrandLogo(BuildContext context, bool isDark, String brandName) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isDark ? TColors.darkerGrey : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: TColors.grey.withOpacity(0.3), width: 1),
          ),
          child: Center(
            child: Text(
              brandName[0], // First letter as a placeholder for logo
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? TColors.light : TColors.dark,
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.xs),
        Text(
          brandName,
          style: Theme.of(context).textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Brand Top 3 Product Images
  Widget _buildFeaturedProductsRow(BuildContext context, bool isDark) {
    return Row(
      children: [
        // First Featured Product
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Navigate to product details
            },
            child: Stack(
              children: [
                // Container with enhanced border and styling
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(right: TSizes.sm),
                  decoration: BoxDecoration(
                    color: isDark ? TColors.darkerGrey : TColors.light,
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: isDark ? TColors.darkerGrey : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      TSizes.cardRadiusLg - 1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: const Image(
                        fit: BoxFit.contain,
                        image: AssetImage(TImages.productImage4),
                      ),
                    ),
                  ),
                ),

                // Improved discount tag with shadow
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(TSizes.sm),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      '-25%',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: TColors.light,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                // Add a subtle shine effect for a premium look
                Positioned(
                  top: 0,
                  left: 0,
                  right: TSizes.sm,
                  height: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusLg),
                        topRight: Radius.circular(TSizes.cardRadiusLg),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Second Featured Product
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Navigate to product details
            },
            child: Stack(
              children: [
                cured.TRoundedContainer(
                  height: 120,
                  backgroundColor: isDark ? TColors.darkerGrey : TColors.light,
                  margin: const EdgeInsets.only(right: TSizes.sm),
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.sm),
                    child: const Image(
                      fit: BoxFit.contain,
                      image: AssetImage(TImages.productImage3),
                    ),
                  ),
                ),
                // New tag
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(TSizes.sm),
                    ),
                    child: Text(
                      'NEW',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: TColors.light,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Third Featured Product
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Navigate to product details
            },
            child: Stack(
              children: [
                cured.TRoundedContainer(
                  height: 120,
                  backgroundColor: isDark ? TColors.darkerGrey : TColors.light,
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.sm),
                    child: const Image(
                      fit: BoxFit.contain,
                      image: AssetImage(TImages.productImage2),
                    ),
                  ),
                ),
                // Top rated tag
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(TSizes.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          '4.9',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            color: TColors.light,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Delegate class for SliverAppBar with TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color:
          THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.light,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
