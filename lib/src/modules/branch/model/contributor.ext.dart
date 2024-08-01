part of 'contributor.dart';

extension ContributorExtension on Contributor {
  Contributor copyWith({
    String? id,
    String? store,
    String? management,
    String? branch,
    String? role,
    DateTime? created,
    DateTime? updated,
  }) {
    return Contributor(
      id: id ?? this.id,
      store: store ?? this.store,
      management: management ?? this.management,
      branch: branch ?? this.branch,
      role: role ?? this.role,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.store: store,
      _Json.management: management,
      _Json.branch: branch,
      _Json.role: role,
      _Json.created: created.toIso8601String(),
      _Json.updated: updated.toIso8601String(),
    };
  }

  String toRawJson() => json.encode(toJson());
}
