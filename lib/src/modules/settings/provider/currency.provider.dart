import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/hive.dart';
import '../model/currency/currency.model.dart';

typedef CurrencyNotifier
    = AutoDisposeNotifierProvider<CurrencyProvider, List<CurrencyProfile>>;

final currencyProvider = CurrencyNotifier(CurrencyProvider.new);

class CurrencyProvider extends AutoDisposeNotifier<List<CurrencyProfile>> {
  final searchCntrlr = TextEditingController();
  late List<CurrencyProfile> _currencies;

  @override
  List<CurrencyProfile> build() {
    _listener();
    _currencies = Boxes.currencyProfile.values.toList();
    return currencies;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  List<CurrencyProfile> get currencies {
    _currencies.sort((a, b) => a.name.compareTo(b.name));
    final cs = _currencies;
    return cs
        .where((e) =>
            e.name.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.shortForm
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            e.symbol.toLowerCase().contains(searchCntrlr.text.toLowerCase()))
        .toList();
  }
}

// class _Data {
//   _Data(this.setting, this.currency);

//   final String currency;
//   final AppSettings setting;
// }

// Future<void> _changeCurrency(_Data data) async {
//   await initHiveDB();
//   data.setting.currency = data.currency;
//   await Boxes.appSettings.put(appName, data.setting);
// }
