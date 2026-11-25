import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsLocalDataSource {
  String? getLanguageCode();
  Future<void> saveLanguageCode(String code);
  bool isOnboardingDone();
  Future<void> setOnboardingDone();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;

  static const _kLanguage = 'language_code';
  static const _kOnboarding = 'onboarding_done';

  @override
  String? getLanguageCode() => _prefs.getString(_kLanguage);

  @override
  Future<void> saveLanguageCode(String code) =>
      _prefs.setString(_kLanguage, code);

  @override
  bool isOnboardingDone() => _prefs.getBool(_kOnboarding) ?? false;

  @override
  Future<void> setOnboardingDone() => _prefs.setBool(_kOnboarding, true);
}
