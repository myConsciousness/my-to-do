


import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String hello(Object name) {
    return 'ようこそ $name';
  }

  @override
  String get login => 'ログイン';

  @override
  String get info => '情報';

  @override
  String get allow => '許可';

  @override
  String get deny => 'DENY!';
}
