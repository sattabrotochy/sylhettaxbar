import '../../../core/presentation/base_view_model.dart';
import '../domain/app_info.dart';

class AppInfoViewModel extends BaseViewModel {
  AppInfoViewModel(this._getAppInfo);

  final GetAppInfo _getAppInfo;

  AppInfo? _info;
  AppInfo? get info => _info;

  Future<void> load() async {
    setStatus(ViewStatus.loading);
    final result = await _getAppInfo();
    result.when(
      success: (i) {
        _info = i;
        setStatus(ViewStatus.success);
      },
      failure: (f) => setStatus(ViewStatus.error, failure: f),
    );
  }
}
