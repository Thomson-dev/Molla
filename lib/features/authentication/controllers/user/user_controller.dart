import 'package:get/get.dart';
import 'package:molla/features/authentication/model/user_model.dart';
import 'package:molla/features/authentication/repositories/authentication_repository.dart';

import 'dart:io';

import 'package:molla/utils/theme/color.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Observable user data
  final Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(AuthenticationRepository());

  // Loading state for profile operations
  final profileLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final userDetails = await userRepository.fetchUserDetails();
      print("Fetched user details: $userDetails"); // Add logging here

      if (userDetails != null) {
        this.user(userDetails); // Update the reactive user
      } else {
        print("User details are null or empty");
        user(UserModel.empty()); // Set empty state if nothing is returned
      }
    } catch (e) {
      print("Error fetching user details: $e"); // Log any error that occurs
      user(UserModel.empty()); // Fallback to empty state
    } finally {
      profileLoading.value = false;
    }
  }

  /// Update user profile information
  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profilePicture,
  }) async {
    try {
      profileLoading.value = true;

      // Create updated user model
      final updatedUser = user.value.copyWith(
        firstName: firstName ?? user.value.firstName,
        lastName: lastName ?? user.value.lastName,
        phoneNumber: phoneNumber ?? user.value.phoneNumber,
        profilePicture: profilePicture ?? user.value.profilePicture,
      );

      // Update in database
      await userRepository.updateUserDetails(updatedUser);

      // Update local state
      user.value = updatedUser;

      // Show success message
      Get.snackbar(
        'Updated!',
        'Your profile has been updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Show error
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      throw e; // Rethrow to handle in the UI
    } finally {
      profileLoading.value = false;
    }
  }

  /// Delete user account
  Future<void> deleteUserAccount() async {
    try {
      profileLoading.value = true;

      // Delete user data from Firestore
      await userRepository.deleteUserData();

      // Delete the user authentication account
      await userRepository.deleteUserAccount();

      // Sign out after deletion
      await userRepository.logout();

      // Navigate to login or welcome screen
      Get.offAllNamed('/login'); // Adjust route as needed for your app

      Get.snackbar(
        'Account Deleted',
        'Your account has been permanently deleted.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TColors.error,
        colorText: TColors.light,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete account: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TColors.error,
        colorText: TColors.light,
      );
      throw e;
    } finally {
      profileLoading.value = false;
    }
  }

  /// Upload and update profile picture
  // Future<void> uploadProfilePicture({required bool isCamera}) async {
  //   try {
  //     profileLoading.value = true;

  //     // 1. Select image from camera or gallery using image_picker
  //     final ImagePicker picker = ImagePicker();
  //     final XFile? image = await picker.pickImage(
  //       source: isCamera ? ImageSource.camera : ImageSource.gallery,
  //       imageQuality: 70,
  //     );

  //     if (image == null) {
  //       profileLoading.value = false;
  //       return;
  //     }

  //     // 2. Upload to Firebase Storage
  //     final file = File(image.path);
  //     final userId = AuthenticationRepository.instance.authUser?.uid;

  //     if (userId == null) {
  //       throw 'User not authenticated';
  //     }

  //     // Create storage reference
  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('profile_images')
  //         .child('$userId.jpg');

  //     // Upload image
  //     await storageRef.putFile(file);

  //     // Get download URL
  //     final downloadURL = await storageRef.getDownloadURL();

  //     // 3. Update user profile with new image URL
  //     await updateUserProfile(profilePicture: downloadURL);

  //     Get.snackbar(
  //       'Success',
  //       'Profile picture updated successfully',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to update profile picture: $e',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }
}
