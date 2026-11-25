import 'package:flutter/foundation.dart';

import '../../../../core/localization/app_language.dart';
import '../../../../core/localization/app_strings.dart';
import '../../domain/repositories/settings_repository.dart';

/// App-wide settings: language and onboarding state.
class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._repository)
      : _language = _repository.getLanguage(),
        _onboardingDone = _repository.isOnboardingDone();

  final SettingsRepository _repository;

  AppLanguage _language;
  bool _onboardingDone;

  AppLanguage get language => _language;
  AppStrings get strings => AppStrings(_language);
  bool get onboardingDone => _onboardingDone;

  Future<void> setLanguage(AppLanguage language) async {
    if (language == _language) return;
    _language = language;
    notifyListeners();
    await _repository.saveLanguage(language);
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    notifyListeners();
    await _repository.completeOnboarding();
  }
}
