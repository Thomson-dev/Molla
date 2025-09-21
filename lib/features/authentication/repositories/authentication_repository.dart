import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:molla/features/authentication/model/user_model.dart';
import 'package:molla/utils/exceptions/firebase_exceptions.dart';
import 'package:molla/utils/popups/fullscreen_loader.dart';

class AuthenticationRepository extends GetxController {
  // Singleton
  static AuthenticationRepository get instance => Get.find();

  // Database instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final deviceStorage = GetStorage();

  // Reactive state
  final Rx<bool> isInitializing = true.obs;

  // Current authenticated user
  User? get authUser => _auth.currentUser;

  /// Called after dependency injection is complete
  @override
  void onReady() {
    FlutterNativeSplash.remove(); // Remove native splash
    _init();
  }

  /// Initializes the repository
  Future<void> _init() async {
    // Set first-time flag if not present
    deviceStorage.writeIfNull("isFirstTime", true);

    // Simulate small delay for smoother UX (optional)
    await Future.delayed(const Duration(milliseconds: 500));

    isInitializing.value = false;
  }

  /// Login with email and password
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Attempt to sign in with the provided credentials
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user authentication token if needed
      deviceStorage.write(
        'AUTH_TOKEN',
        await userCredential.user?.getIdToken(),
      );
      deviceStorage.write('USER_ID', userCredential.user?.uid);

      // Return the user credential for further processing
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific authentication errors with user-friendly messages
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage =
              'Too many failed login attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password sign-in is not enabled.';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          errorMessage = e.message ?? 'An authentication error occurred.';
      }
      throw errorMessage;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Login failed. Please try again.";
    }
  }

  /// Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
  }

  /// Logout user
  Future<void> logout() async {
    try {
      // Show loading indicator
      TFullScreenLoader.openLoadingDialog('Logging out...');

      // Sign out from Firebase
      await _auth.signOut();

      // Clear any stored credentials
      // Only clear authentication tokens, not remember-me settings
      deviceStorage.remove('AUTH_TOKEN');
      deviceStorage.remove('USER_ID');
      // Add any other auth-related keys you want to clear

      // Close loading indicator
      TFullScreenLoader.stopLoading();

      // Navigate to login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/login'); // Replace with your login route
      });
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Get.snackbar(
        'Error',
        'Failed to logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Function to save user data to Firestore with proper error handling
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      // Check if auth user is null before proceeding
      if (authUser == null) {
        print("fetchUserDetails: Auth user is null");
        return UserModel.empty();
      }

      print(
        "fetchUserDetails: Fetching document for user ID: ${authUser!.uid}",
      );

      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _db.collection('users').doc(authUser!.uid).get();

      if (documentSnapshot.exists) {
        print(
          "fetchUserDetails: Document exists with data: ${documentSnapshot.data()}",
        );
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        print(
          "fetchUserDetails: No document exists for user ID: ${authUser!.uid}",
        );
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      print("fetchUserDetails: FirebaseException: ${e.code} - ${e.message}");
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      print("fetchUserDetails: FormatException: $e");
      throw const TFormatException();
    } on PlatformException catch (e) {
      print("fetchUserDetails: PlatformException: ${e.code} - ${e.message}");
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("fetchUserDetails: Unexpected error: $e");
      throw "Something went wrong. Please try again";
    }
  }

  /// Function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("users")
          .doc(updatedUser.id)
          .update(updatedUser.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Function to remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> loginWithPhoneNo(String phoneNo) async {
    // Implement phone authentication when ready
    Get.snackbar(
      'Not Supported',
      'Phone login is not implemented yet.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }


  /// Delete user data from Firestore
Future<void> deleteUserData() async {
  try {
    final userId = authUser?.uid;
    if (userId == null) throw 'User not authenticated';
    
    // Delete user document from Firestore
    await FirebaseFirestore.instance.collection('Users').doc(userId).delete();
    
    // If you have other collections with user data, delete them here
    // For example:
    // await FirebaseFirestore.instance.collection('UserPosts').where('userId', isEqualTo: userId).get()
    //   .then((snapshot) {
    //     for (DocumentSnapshot ds in snapshot.docs) {
    //       ds.reference.delete();
    //     }
    //   });
  } catch (e) {
    print('Error deleting user data: $e');
    throw e;
  }
}

/// Delete user authentication account
  Future<void> deleteUserAccount() async {
  try {
    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw 'User not authenticated';
    
    // Delete the user account
    await user.delete();
  } on FirebaseAuthException catch (e) {
    // Handle specific Firebase Auth exceptions
    if (e.code == 'requires-recent-login') {
      // If the user has been authenticated for too long, re-authentication is needed
      throw 'Please sign out and sign in again before deleting your account';
    } else {
      print('Error deleting user account: $e');
      throw e.toString();
    }
  } catch (e) {
    print('Error deleting user account: $e');
    throw e;
  }
}
}
