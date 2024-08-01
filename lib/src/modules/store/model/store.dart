// {
//     "id": "170a5786-afb4-4931-9ae5-0a001ac88b93",
//     "name": "Fkommerce",
//     "username": null,
//     "country": "Bangladesh",
//     "country_code": "BD",
//     "currency": "BDT",
//     "currency_symbol": "৳",
//     "dialing_code": "+880",
//     "phone_number_length": 10,
//     "logo_url": null,
//     "trade_licence_url": null,
//     "bin_certificate_url": null,
//     "tin_certificate_url": null,
//     "created": "2024-08-01T10:10:33.328Z",
//     "updated": "2024-08-01T10:10:33.328Z"
// },

import 'dart:convert';

part 'store.ext.dart';

class Store {
  final String id;
  String name;
  String? username;
  String country;
  String countryCode;
  String currency;
  String currencySymbol;
  String dialingCode;
  int phoneNumberLength;
  String? logoUrl;
  String? tradeLicenceUrl;
  String? binCertificateUrl;
  String? tinCertificateUrl;
  DateTime created;
  DateTime updated;

  Store({
    required this.id,
    required this.name,
    this.username,
    required this.country,
    required this.countryCode,
    required this.currency,
    required this.currencySymbol,
    required this.dialingCode,
    required this.phoneNumberLength,
    this.logoUrl,
    this.tradeLicenceUrl,
    this.binCertificateUrl,
    this.tinCertificateUrl,
    required this.created,
    required this.updated,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json[_Json.id],
      name: json[_Json.name],
      username: json[_Json.username],
      country: json[_Json.country],
      countryCode: json[_Json.countryCode],
      currency: json[_Json.currency],
      currencySymbol: json[_Json.currencySymbol],
      dialingCode: json[_Json.dialingCode],
      phoneNumberLength: json[_Json.phoneNumberLength],
      logoUrl: json[_Json.logoUrl],
      tradeLicenceUrl: json[_Json.tradeLicenceUrl],
      binCertificateUrl: json[_Json.binCertificateUrl],
      tinCertificateUrl: json[_Json.tinCertificateUrl],
      created: DateTime.parse(json[_Json.created]),
      updated: DateTime.parse(json[_Json.updated]),
    );
  }

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Store && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const username = 'username';
  static const country = 'country';
  static const countryCode = 'country_code';
  static const currency = 'currency';
  static const currencySymbol = 'currency_symbol';
  static const dialingCode = 'dialing_code';
  static const phoneNumberLength = 'phone_number_length';
  static const logoUrl = 'logo_url';
  static const tradeLicenceUrl = 'trade_licence_url';
  static const binCertificateUrl = 'bin_certificate_url';
  static const tinCertificateUrl = 'tin_certificate_url';
  static const created = 'created';
  static const updated = 'updated';
}
