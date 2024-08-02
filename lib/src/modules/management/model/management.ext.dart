part of 'management.dart';

extension ManagementExtension on Management {
  Management copyWith({
    String? id,
    String? email,
    bool? isEmailVerified,
    String? phone,
    bool? isPhoneVerified,
    String? password,
    String? name,
    String? avatar,
    String? fcmToken,
    DateTime? created,
    DateTime? updated,
  }) {
    return Management(
      id: id ?? this.id,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      phone: phone ?? this.phone,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      password: password ?? this.password,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      fcmToken: fcmToken ?? this.fcmToken,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.email: email,
        _Json.isEmailVerified: isEmailVerified,
        _Json.phone: phone,
        _Json.isPhoneVerified: isPhoneVerified,
        _Json.password: password,
        _Json.name: name,
        _Json.avatar: avatar,
        _Json.fcmToken: fcmToken,
        _Json.created: created.toIso8601String(),
        _Json.updated: updated.toIso8601String(),
      };

  String toRawJson() => json.encode(toJson());
}