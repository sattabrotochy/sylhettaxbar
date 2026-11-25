import '../../../../core/localization/app_language.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._local);
  final SettingsLocalDataSource _local;

  @override
  AppLanguage getLanguage() => AppLanguage.fromCode(_local.getLanguageCode());

  @override
  Future<void> saveLanguage(AppLanguage language) =>
      _local.saveLanguageCode(language.code);

  @override
  bool isOnboardingDone() => _local.isOnboardingDone();

  @override
  Future<void> completeOnboarding() => _local.setOnboardingDone();
}
