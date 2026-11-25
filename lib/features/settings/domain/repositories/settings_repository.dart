import '../../../../core/localization/app_language.dart';

abstract interface class SettingsRepository {
  AppLanguage getLanguage();
  Future<void> saveLanguage(AppLanguage language);
  bool isOnboardingDone();
  Future<void> completeOnboarding();
}
