// {
//   "id": "33dd52ec-4ada-453a-9cc8-bb89dbdcaed1",
//   "store": "170a5786-afb4-4931-9ae5-0a001ac88b93",
//   "management": "2cc16d30-838d-45fc-bb55-8070a6676d06",
//   "branch": "cf346443-b400-47aa-a59d-904ec29ed282",
//   "role": "owner",
//   "created": "2024-08-01T10:10:33.337Z",
//   "updated": "2024-08-01T10:10:33.337Z"
// }

import 'dart:convert';

part 'contributor.ext.dart';

class Contributor {
  final String id;
  final String store;
  final String management;
  final String branch;
  String role;
  final DateTime created;
  final DateTime updated;

  Contributor({
    required this.id,
    required this.store,
    required this.management,
    required this.branch,
    required this.role,
    required this.created,
    required this.updated,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      id: json[_Json.id],
      store: json[_Json.store],
      management: json[_Json.management],
      branch: json[_Json.branch],
      role: json[_Json.role],
      created: DateTime.parse(json[_Json.created]),
      updated: DateTime.parse(json[_Json.updated]),
    );
  }

  factory Contributor.fromRawJson(String str) =>
      Contributor.fromJson(json.decode(str));

  static List<Contributor> listFromJson(List<dynamic> json) =>
      List<Contributor>.from(json.map((v) => Contributor.fromJson(v)));

  static List<Contributor> listFromRawJson(String str) =>
      listFromJson(json.decode(str));

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Contributor && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const store = 'store';
  static const management = 'management';
  static const branch = 'branch';
  static const role = 'role';
  static const created = 'created';
  static const updated = 'updated';
}
