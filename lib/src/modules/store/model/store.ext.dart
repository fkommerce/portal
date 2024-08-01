part of 'store.dart';

extension StoreExtension on Store {
  Store copyWith({
    String? id,
    String? name,
    String? username,
    String? country,
    String? countryCode,
    String? currency,
    String? currencySymbol,
    String? dialingCode,
    int? phoneNumberLength,
    String? logoUrl,
    String? tradeLicenceUrl,
    String? binCertificateUrl,
    String? tinCertificateUrl,
    DateTime? created,
    DateTime? updated,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      dialingCode: dialingCode ?? this.dialingCode,
      phoneNumberLength: phoneNumberLength ?? this.phoneNumberLength,
      logoUrl: logoUrl ?? this.logoUrl,
      tradeLicenceUrl: tradeLicenceUrl ?? this.tradeLicenceUrl,
      binCertificateUrl: binCertificateUrl ?? this.binCertificateUrl,
      tinCertificateUrl: tinCertificateUrl ?? this.tinCertificateUrl,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.name: name,
      _Json.username: username,
      _Json.country: country,
      _Json.countryCode: countryCode,
      _Json.currency: currency,
      _Json.currencySymbol: currencySymbol,
      _Json.dialingCode: dialingCode,
      _Json.phoneNumberLength: phoneNumberLength,
      _Json.logoUrl: logoUrl,
      _Json.tradeLicenceUrl: tradeLicenceUrl,
      _Json.binCertificateUrl: binCertificateUrl,
      _Json.tinCertificateUrl: tinCertificateUrl,
      _Json.created: created.toIso8601String(),
      _Json.updated: updated.toIso8601String(),
    };
  }

  String toRawJson() => json.encode(toJson());
}
