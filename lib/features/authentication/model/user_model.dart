import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final bool isEmailVerified;
  final bool isProfileActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String verificationStatus;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePicture = '',
    this.isEmailVerified = false,
    this.isProfileActive = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.verificationStatus = '',
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  String get fullName => '$firstName $lastName';

  // Simple formatter placeholder — replace with your formatter if available
  String get formattedPhone {
    if (phoneNumber.isEmpty) return '';
    // remove non-digit chars and return digits (simple canonicalization)
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return digits.isEmpty ? phoneNumber : digits;
  }

  /// Helper to split full name into parts (first, last, etc.)
  static List<String> nameParts(String fullName) {
    return fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((s) => s.isNotEmpty)
        .toList();
  }

  /// Generate a simple username from a full name.
  /// Example: "John Doe" -> "cwt_johndoe"
  static String generateUsername(String fullName) {
    final parts = nameParts(fullName);
    final first = parts.isNotEmpty ? parts[0].toLowerCase() : '';
    final last = parts.length > 1 ? parts.sublist(1).join().toLowerCase() : '';
    final base = (first + last).replaceAll(RegExp(r'[^a-z0-9]'), '');
    final username =
        base.isEmpty
            ? 'user_${DateTime.now().millisecondsSinceEpoch}'
            : 'cwt_$base';
    return username;
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    bool? isEmailVerified,
    bool? isProfileActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? verificationStatus,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'isEmailVerified': isEmailVerified,
      'isProfileActive': isProfileActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'verificationStatus': verificationStatus,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['uid'] ?? map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      isEmailVerified: map['isEmailVerified'] ?? false,
      isProfileActive: map['isProfileActive'] ?? false,
      createdAt:
          map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
              : DateTime.now(),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.tryParse(map['updatedAt']) ?? DateTime.now()
              : DateTime.now(),
      verificationStatus: map['verificationStatus'] ?? '',
    );
  }

  // Add this static method to create a UserModel from a DocumentSnapshot
  static UserModel fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    try {
      final data = snapshot.data() ?? {};
      print("UserModel.fromSnapshot: Raw data: $data");

      // Safely handle createdAt which could be a String or Timestamp
      DateTime? createdAt;
      if (data['createdAt'] != null) {
        if (data['createdAt'] is Timestamp) {
          createdAt = (data['createdAt'] as Timestamp).toDate();
        } else if (data['createdAt'] is String) {
          // Parse the string date
          try {
            createdAt = DateTime.parse(data['createdAt'] as String);
          } catch (e) {
            print("Error parsing createdAt string: $e");
          }
        }
      }

      return UserModel(
        id:
            data['uid'] ??
            snapshot.id, // Use 'uid' field if it exists, otherwise use doc ID
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        createdAt: createdAt ?? DateTime.now(),
      );
    } catch (e) {
      print("UserModel.fromSnapshot: Error parsing data: $e");
      // Return an empty model with the document ID to avoid losing the ID
      return UserModel(
        id: snapshot.id,
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        createdAt: DateTime.now(),
      );
    }
  }

  /// Returns an empty UserModel instance
  static UserModel empty() {
    return UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      isEmailVerified: false,
      isProfileActive: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      verificationStatus: '',
    );
  }
}
