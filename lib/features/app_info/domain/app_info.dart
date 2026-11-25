import '../../../core/utils/result.dart';

class AppInfo {
  const AppInfo({required this.name, required this.versionCode});
  final String name;
  final String versionCode;
}

abstract interface class AppInfoRepository {
  Future<Result<AppInfo>> getAppInfo();
}

class GetAppInfo {
  const GetAppInfo(this._repository);
  final AppInfoRepository _repository;

  Future<Result<AppInfo>> call() => _repository.getAppInfo();
}
