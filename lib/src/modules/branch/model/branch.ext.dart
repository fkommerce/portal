part of 'branch.dart';

extension BranchExtension on Branch {
  Branch copyWith({
    String? id,
    String? store,
    String? name,
    List<String>? helplinePhoneNumbers,
    List<String>? helplineEmails,
    DateTime? created,
    DateTime? updated,
  }) {
    return Branch(
      id: id ?? this.id,
      store: store ?? this.store,
      name: name ?? this.name,
      helplinePhoneNumbers: helplinePhoneNumbers ?? this.helplinePhoneNumbers,
      helplineEmails: helplineEmails ?? this.helplineEmails,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.store: store,
      _Json.name: name,
      _Json.helplinePhoneNumbers: helplinePhoneNumbers,
      _Json.helplineEmails: helplineEmails,
      _Json.created: created.toIso8601String(),
      _Json.updated: updated.toIso8601String(),
    };
  }

  String toRawJson() => json.encode(toJson());
}