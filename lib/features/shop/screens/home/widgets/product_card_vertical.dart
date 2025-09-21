import 'package:flutter/material.dart';
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
  late final AnimationController _controller;
  late final Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _press(bool down) {
    if (_pressed != down) {
      setState(() => _pressed = down);
      down ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    // Breakpoints
    final width = MediaQuery.of(context).size.width;
    final small = width < 380;
    final large = width > 600;

    // Quick responsive helpers
    double r(double s, double m, double l) =>
        small
            ? s
            : large
            ? l
            : m;

    return GestureDetector(
      onTapDown: (_) => _press(true),
      onTapUp: (_) => _press(false),
      onTapCancel: () => _press(false),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: r(15, 20, 25),
                offset: Offset(0, r(6, 8, 10)),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: dark ? TColors.darkerGrey : TColors.light,
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductImage(
                  image: widget.image,
                  dark: dark,
                  discountTag: widget.discountTag,
                  isFavorite: widget.isFavorite,
                  onFavoriteTap: widget.onFavoriteTap,
                  height: r(140, 160, 180),
                  iconSize: r(18, 20, 22),
                ),
                Padding(
                  padding: EdgeInsets.all(r(8, 10, 14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: large ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: r(14, 15, 17), // increased
                          fontWeight: FontWeight.w600,
                          color: dark ? TColors.light : TColors.dark,
                        ),
                      ),
                      SizedBox(height: r(4, 5, 6)),
                      Row(
                        children: [
                          Text(
                            '\$${widget.price.toStringAsFixed(2)}',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontSize: r(15, 17, 18), // increased
                              color: TColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.oldPrice != null) ...[
                            SizedBox(width: r(4, 5, 6)),
                            Text(
                              '\$${widget.oldPrice!.toStringAsFixed(2)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: r(12, 13, 14), // increased
                                decoration: TextDecoration.lineThrough,
                                color: TColors.grey,
                              ),
                            ),
                          ],
                          const Spacer(),
                          Icon(
                            Icons.star,
                            size: r(12, 14, 16),
                            color: Colors.amber,
                          ),
                          SizedBox(width: r(2, 3, 4)),
                          Text(
                            '4.0',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: r(12, 13, 14), // increased
                              color: TColors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: r(10, 12, 14)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _AddToCartButton(
                          onTap: widget.onTap,
                          dark: dark,
                          width: r(55, 65, 75),
                          height: r(33, 40, 44),
                          iconSize: r(14, 16, 18),
                          showText: large,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String image;
  final bool dark;
  final String? discountTag;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final double height;
  final double iconSize;

  const _ProductImage({
    required this.image,
    required this.dark,
    required this.discountTag,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.height,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
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
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              errorBuilder:
                  (_, __, ___) => Icon(
                    Icons.image_not_supported_outlined,
                    size: height * 0.3,
                    color: TColors.grey,
                  ),
            ),
          ),
        ),
        if (discountTag != null)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: TColors.secondary,
                borderRadius: BorderRadius.circular(TSizes.sm),
              ),
              child: Text(
                discountTag!,
                style: const TextStyle(
                  color: TColors.light,
                  fontWeight: FontWeight.bold,
                  fontSize: 13, // increased
                ),
              ),
            ),
          ),
        Positioned(
          top: 4,
          right: 4,
          child: CircleAvatar(
            backgroundColor: dark ? Colors.black38 : Colors.white,
            child: IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: iconSize,
                color: isFavorite ? Colors.red : TColors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool dark;
  final double width;
  final double height;
  final double iconSize;
  final bool showText;

  const _AddToCartButton({
    required this.onTap,
    required this.dark,
    required this.width,
    required this.height,
    required this.iconSize,
    required this.showText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: TColors.primary),
        borderRadius: BorderRadius.circular(4),
        color: dark ? Colors.transparent : TColors.light.withOpacity(0.7),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: iconSize,
                  color: dark ? TColors.light : TColors.primary,
                ),
                if (showText) ...[
                  const SizedBox(width: 4),
                  Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 14, // increased
                      color: dark ? TColors.light : TColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
