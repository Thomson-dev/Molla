import 'package:flutter/material.dart';
import 'package:molla/features/shop/screens/home/widgets/category_item.dart';
import 'package:molla/utils/constants/sizes.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 190,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Popular Categories',
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              height: 80,
              child: GestureDetector(
                onTap: () {
                  // Navigate to categories page or handle the tap event
                  debugPrint('Category list tapped');
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6, // Change this to your actual category count
                  itemBuilder: (context, index) {
                    return const CategoryItem(
                      icon: 'assets/images/icons8-shoes-64.png',
                      title: 'Shoes Category',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}