import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String hello(Object name) {
    return 'Hello $name';
  }

  @override
  String get login => 'Login';

  @override
  String get info => 'Info';

  @override
  String get allow => 'ALLOW!';

  @override
  String get deny => 'DENY!';
}
