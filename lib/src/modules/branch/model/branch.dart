// {
//   "id": "cf346443-b400-47aa-a59d-904ec29ed282",
//   "store": "170a5786-afb4-4931-9ae5-0a001ac88b93",
//   "name": "Main Branch",
//   "helpline_phone_numbers": [
//       "+8801647629698"
//   ],
//   "helpline_emails": [
//       "fkommerce@algoramming.com"
//   ],
//   "created": "2024-08-01T10:10:33.332Z",
//   "updated": "2024-08-01T10:10:33.332Z"
// }

import 'dart:convert';

part 'branch.ext.dart';

class Branch {
  final String id;
  final String store;
  String name;
  List<String> helplinePhoneNumbers;
  List<String> helplineEmails;
  DateTime created;
  DateTime updated;

  Branch({
    required this.id,
    required this.store,
    required this.name,
    required this.helplinePhoneNumbers,
    required this.helplineEmails,
    required this.created,
    required this.updated,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json[_Json.id],
      store: json[_Json.store],
      name: json[_Json.name],
      helplinePhoneNumbers: List<String>.from(json[_Json.helplinePhoneNumbers]),
      helplineEmails: List<String>.from(json[_Json.helplineEmails]),
      created: DateTime.parse(json[_Json.created]),
      updated: DateTime.parse(json[_Json.updated]),
    );
  }

  factory Branch.fromRawJson(String str) => Branch.fromJson(json.decode(str));

  static List<Branch> listFromJson(List<dynamic> json) =>
      List<Branch>.from(json.map((v) => Branch.fromJson(v)));

  static List<Branch> listFromRawJson(String str) =>
      listFromJson(json.decode(str));

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Branch && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const store = 'store';
  static const name = 'name';
  static const helplinePhoneNumbers = 'helpline_phone_numbers';
  static const helplineEmails = 'helpline_emails';
  static const created = 'created';
  static const updated = 'updated';
}
