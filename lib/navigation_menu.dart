import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:molla/features/shop/screens/home/home.dart';
import 'package:molla/features/shop/screens/store/store.dart';

import 'package:molla/utils/helpers/helper_functions.dart';
import 'package:molla/utils/theme/color.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    StoreScreen(),
    Container(color: Colors.orange),
    Container(color: Colors.blue),
  ];
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.dark : Colors.white,
          indicatorColor:
              darkMode
                  ? Colors.white.withOpacity(0.1)
                  : TColors.dark.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
        body: controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}
