part of 'currency.model.dart';

const bdtNumberFormat = '৳#,##,##0.00#';
const usdNumberFormat = '\$#,##0.00';

extension CurrencyTrxExt on CurrencyProfile {
  String? get numberPattern => shortForm == 'BDT' ? bdtNumberFormat : null;

  Future<void> saveData() async => await Boxes.currencyProfile.put(id, this);

  Future<void> deleteData() async => await Boxes.currencyProfile.delete(id);
}

extension ListCurrencyTrxExt on List<CurrencyProfile> {

  Future<void> saveAllData() async => await Boxes.currencyProfile
      .putAll(Map.fromEntries(map((e) => MapEntry(e.id, e))));

  Future<void> deleteAllData() async =>
      await Boxes.currencyProfile.deleteAll(map((e) => e.id).toList());
}
