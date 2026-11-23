import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a user's profile document stored in the
/// `users` Firestore collection, keyed by their Firebase Auth uid.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final int avatarIndex;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone = '',
    this.avatarIndex = 0,
    this.createdAt,
    this.updatedAt,
  });

  /// Data to write to Firestore. Use [isNew] to set createdAt only once.
  Map<String, dynamic> toMap({bool isNew = false}) {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatarIndex': avatarIndex,
      if (isNew) 'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      avatarIndex: (map['avatarIndex'] ?? 0) as int,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    int? avatarIndex,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
