import 'package:flutter/material.dart';
import 'package:molla/utils/constants/sizes.dart';
import 'package:molla/utils/theme/color.dart';

/// Extracted Category Item for reusability
class CategoryItem extends StatelessWidget {
  final String icon;
  final String title;

  const CategoryItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: TSizes.defaultSpace),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(TSizes.sm),
            decoration: BoxDecoration(
              color: isDark ? TColors.dark : TColors.light,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Image(
                image: AssetImage(icon),
                fit: BoxFit.cover,
                color: isDark ? TColors.light : TColors.dark,
                errorBuilder:
                    (context, error, stackTrace) => Icon(
                      Icons.error_outline,
                      color: isDark ? TColors.light : TColors.dark,
                    ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          SizedBox(
            width: 56,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                color: isDark ? TColors.light : TColors.dark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}