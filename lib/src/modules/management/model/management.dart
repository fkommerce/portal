// {
//     "id": "2cc16d30-838d-45fc-bb55-8070a6676d06",
//     "email": "fkommerce@algoramming.com",
//     "is_email_verified": false,
//     "phone": "+8801647629698",
//     "is_phone_verified": false,
//     "password": "$2b$10$lEQaq0WiYCaPWtAzMU60CunO4N1jR9NqBdHLer.0GXhIEOtKH5Zvq",
//     "name": "Md. Sabik Alam Rahat",
//     "avatar": null,
//     "fcm_token": "BMJduVOLEahQLODbiRNT",
//     "created": "2024-08-01T10:10:28.703Z",
//     "updated": "2024-08-01T10:10:28.703Z"
// },

import 'dart:convert';

part 'management.ext.dart';

class Management {
  final String id;
  final String email;
  bool isEmailVerified;
  String phone;
  bool isPhoneVerified;
  String password;
  String name;
  String? avatar;
  final String fcmToken;
  final DateTime created;
  final DateTime updated;

  Management({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    required this.phone,
    required this.isPhoneVerified,
    required this.password,
    required this.name,
    this.avatar,
    required this.fcmToken,
    required this.created,
    required this.updated,
  });

  factory Management.fromJson(Map<String, dynamic> json) => Management(
        id: json[_Json.id],
        email: json[_Json.email],
        isEmailVerified: json[_Json.isEmailVerified],
        phone: json[_Json.phone],
        isPhoneVerified: json[_Json.isPhoneVerified],
        password: json[_Json.password],
        name: json[_Json.name],
        avatar: json[_Json.avatar],
        fcmToken: json[_Json.fcmToken],
        created: DateTime.parse(json[_Json.created]),
        updated: DateTime.parse(json[_Json.updated]),
      );

  factory Management.fromRawJson(String str) =>
      Management.fromJson(json.decode(str));

  static List<Management> listFromJson(List<dynamic> json) =>
      List<Management>.from(json.map((x) => Management.fromJson(x)));

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Management && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const email = 'email';
  static const isEmailVerified = 'is_email_verified';
  static const phone = 'phone';
  static const isPhoneVerified = 'is_phone_verified';
  static const password = 'password';
  static const name = 'name';
  static const avatar = 'avatar';
  static const fcmToken = 'fcm_token';
  static const created = 'created';
  static const updated = 'updated';
}
