import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReduxLocalizations {
  final Locale locale;

  ReduxLocalizations(this.locale);

  static ReduxLocalizations of(BuildContext context) {
    return Localizations.of<ReduxLocalizations>(
      context,
      ReduxLocalizations,
    );
  }

  static LocalizationsDelegate<ReduxLocalizations> delegate =
  ReduxLocalizationsDelegate();

  Map<String, String> _localizedValues;

  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedValues =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  String translate(String key) {
    return _localizedValues[key];
  }
}

class ReduxLocalizationsDelegate
    extends LocalizationsDelegate<ReduxLocalizations> {

  ReduxLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['de', 'en'].contains(locale.languageCode.toLowerCase());

  @override
  Future<ReduxLocalizations> load(Locale locale) async {
    ReduxLocalizations localizations = new ReduxLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(ReduxLocalizationsDelegate old) => false;
}
