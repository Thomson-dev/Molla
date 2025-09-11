import 'package:flutter/material.dart';
import 'package:molla/utils/constants/image_strings.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/theme/color.dart';

class TProductCardVertical extends StatefulWidget {
  final String title;
  final String image;
  final double price;
  final double? oldPrice;
  final String? discountTag;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  const TProductCardVertical({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    this.oldPrice,
    this.discountTag,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!_isPressed) {
      _isPressed = true;
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_isPressed) {
      _isPressed = false;
      _animationController.reverse();
    }
  }

  void _onTapCancel() {
    if (_isPressed) {
      _isPressed = false;
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: dark ? TColors.darkerGrey : TColors.light,
                  borderRadius: BorderRadius.circular(
                    TSizes.productImageRadius,
                  ),
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize
                          .min, // Ensure the column doesn't try to expand
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section with overlay elements
                    _buildProductImage(dark),

                    // Details section
                    _buildProductDetails(context, dark),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage(bool dark) {
    return Stack(
      children: [
        // Product image with gradient overlay
        Container(
          height: 150, // Reduced height from 170 to 150
          width: double.infinity,
          decoration: BoxDecoration(
            color: dark ? TColors.dark : Colors.grey[100],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(TSizes.productImageRadius),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(TSizes.productImageRadius),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Product image
                Image.asset(widget.image, fit: BoxFit.contain),

                // Subtle gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Discount tag
        if (widget.discountTag != null)
          Positioned(
            top: 8, // Reduced from 12 to 8
            left: 8, // Reduced from 12 to 8
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ), // Reduced padding
              decoration: BoxDecoration(
                color: TColors.secondary,
                borderRadius: BorderRadius.circular(TSizes.sm),
              ),
              child: Text(
                widget.discountTag!,
                style: const TextStyle(
                  color: TColors.light,
                  fontWeight: FontWeight.bold,
                  fontSize: 10, // Reduced from 12 to 10
                ),
              ),
            ),
          ),

        // Favorite button
        Positioned(
          top: 4, // Reduced from 8 to 4
          right: 4, // Reduced from 8 to 4
          child: Container(
            height: 32, // Reduced from 36 to 32
            width: 32, // Reduced from 36 to 32
            decoration: BoxDecoration(
              color: dark ? Colors.black38 : Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4, // Reduced from 8 to 4
                  spreadRadius: 0.5, // Reduced from 1 to 0.5
                ),
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: widget.onFavoriteTap,
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? Colors.red : TColors.grey,
                size: 18, // Reduced from 20 to 18
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails(BuildContext context, bool dark) {
    return Padding(
      padding: const EdgeInsets.all(8), // Reduced from 12 to 8
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure column only takes needed space
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with maximum 1 line to save space
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 13, // Reduced from 14 to 13
              fontWeight: FontWeight.w600,
              color: dark ? TColors.light : TColors.dark,
            ),
            maxLines: 1, // Reduced from 2 to 1 line
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4), // Reduced from 6 to 4
          // Price row with discount
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${widget.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 15, // Reduced from 16 to 15
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                ),
              ),
              if (widget.oldPrice != null) ...[
                const SizedBox(width: 4), // Reduced from 6 to 4
                Text(
                  '\$${widget.oldPrice!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 11, // Reduced from 12 to 11
                    decoration: TextDecoration.lineThrough,
                    color: TColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              const Spacer(),

              // Combined rating with star icon to save space
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 12, // Reduced from 14 to 12
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '4.0',
                    style: TextStyle(
                      fontSize: 11, // Reduced from 12 to 11
                      color: TColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10), // Reduced from 10 to 6
          // Add to cart button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 28,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: TColors.primary, width: 1.0),
                  color:
                      dark
                          ? Colors.transparent
                          : TColors.light.withOpacity(0.7),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: widget.onTap,
                    splashColor: TColors.primary.withOpacity(0.1),
                    highlightColor: TColors.primary.withOpacity(0.05),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 14,
                            color: dark ? TColors.light : TColors.primary,
                          ),
                          const SizedBox(width: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TRoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;

  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor = TColors.light,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
