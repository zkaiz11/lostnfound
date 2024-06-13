import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? googleUid;
  final String? name;
  final String? email;
  final String? pfp;
  final String? location;
  final bool? isDeleted;
  final Timestamp? createdAt;
  final String? fcmToken;

  UserModel(
    {
    this.googleUid,
    this.name,
    this.email,
    this.pfp,
    this.location,
    this.isDeleted,
    this.createdAt,
    this.fcmToken, 
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      googleUid: json['google_uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      location: json['location'] ?? '',
      pfp: json['profile_url'] ?? '',
      isDeleted: json['is_deleted'] ?? '',
      createdAt: json['created_at'] ?? '',
      fcmToken: json['fcm_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'google_uid': googleUid,
      'name': name,
      'email': email,
      'profile_url': pfp,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'location': location,
      'fcm_token': fcmToken,
    };
  }
}
